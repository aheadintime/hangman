import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hangman/logic/data/hangman_message.dart';
import 'package:hangman/logic/data/hangman_player_guess_message.dart';
import 'package:hangman/logic/data/hangman_player_join_message.dart';
import 'package:hangman/logic/hangman_game_provider.dart';
import 'package:hangman/logic/hangman_state.dart';
import 'package:hangman/logic/hangman_topic.dart';
import 'package:hangman/logic/mqtt/hangman_mqtt.dart';
import 'package:hangman/logic/mqtt/impl/hangman_mqtt_base.dart';
import 'package:hangman/ui/components/hangman_home.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/v4.dart';

part 'hangman_provider.g.dart';

@Riverpod(dependencies: [HangmanGame])
class Hangman extends _$Hangman {

  var _hostName = "wss://broker.emqx.io:8084/mqtt"; //"wss://test.mosquitto.org"; //
  var _port = 8084;
  final _identifier = UuidV4().generate();

  String getHostname() {
    return _hostName;
  }

  int getPort() {
    return _port;
  }

  void setHostname(String hostName) {
    _hostName = hostName;
  }

  void setPort(int port) {
    _port = port;
  }

  Stream<HangmanMqttEvent>? _mqttListener;

  late HangmanMqtt _mqtt;

  bool _connecting = false;
  bool _connected = false;

  late HangmanGameProvider _gameProvider;

  late String _roomId;
  late String _nickname;

  List<String> _players = List.empty(growable: true);

  bool _isGuest = true;

  bool isGuest() {
    return _isGuest;
  }

  String nickname() {
    return _nickname;
  }

  String roomId() {
    return _roomId;
  }

  @override
  HangmanState build() {
    return HangmanHomeState();
  }


  Future<void> connect() async {
    if (_connecting) {
      return;
    }

    _connecting = true;
    _mqtt = HangmanMqtt(_hostName, _port, _identifier, HangmanTopic.players.topic(_roomId), jsonEncode(HangmanPlayerJoinMessage(nickname: _nickname, leaving: true).toJson()));
    _mqtt.onConnected = _onConnected;
    _mqtt.onDisconnected = _onDisconnected;
    _connected = await _mqtt.begin();
    _connecting = false;

  }

  
  void _onConnected() {
    if (kDebugMode) {
      print("connected");
    }
  }

  void _onDisconnected() {
    if (kDebugMode) {
      print("disconnected");
    }
    _connected = false;

    Future.delayed(Duration(seconds: 5), () { connect(); });
  }


  void newRoom(String nickname) async {
    final roomId = UuidV4().generate().substring(0, 6);

    _roomId = roomId;
    _nickname = nickname;

    await connect();

    if (!_connected) {
      
      return;
    }

    List<String> topics = [
      HangmanTopic.guesses,
      HangmanTopic.players
    ].map((topic) {
      return topic.topic(roomId);
    }).toList();

    _mqttListener = _mqtt.streamForTopics(topics);

    _mqttListener!.listen(_onDataHost);

    

    _isGuest = false;

    goToLobby();
  }

  void openConfig() {
    state = HangmanConfigState();
  }

  void goToHome() {
    state = HangmanHomeState();
  }


  void joinRoom(String nickname, String roomId) async {    
    _roomId = roomId;
    _nickname = nickname;
    
    await connect();

     List<String> topics = [
      HangmanTopic.state,
      HangmanTopic.players
    ].map((topic) {
      return topic.topic(roomId);
    }).toList();

    _mqttListener = _mqtt.streamForTopics(topics);

    _mqttListener!.listen(_onDataGuest);

    

    _isGuest = true;

    goToLobby();
  }

  void goToLobby() {
    _sendJoinMessage(_nickname);
    _goToLobby();
  }

  void _goToLobby() {
    state = HangmanLobbyState(players: _players);
  }

  void _sendJoinMessage(String nickname) {
    _pushData(HangmanTopic.players.topic(_roomId), HangmanPlayerJoinMessage(nickname: nickname, leaving: false));
  }

  void startGame(String word) {
    _gameProvider = hangmanGameProvider.call(word);

    ref.listen(_gameProvider, (_, state) {
      _pushData(HangmanTopic.state.topic(_roomId), state);
      this.state = state;
    }, fireImmediately: true);
  }

   void tryLetter(String letter) {
    _pushData(HangmanTopic.guesses.topic(_roomId), HangmanPlayerGuessMessage(nickname: _nickname, letter: letter));
   }


  void _onDataHost(HangmanMqttEvent event) {
     final topic = HangmanTopic.fromString(event.topic);

    if (topic == null) {
      return;
    }

    switch(topic) {
      case HangmanTopic.players:
        _onPlayersData(event.value);
      case HangmanTopic.guesses:
        _onGuessData(event.value);
      default:
        break;
    }

    
  }

  void _onGuessData(dynamic value) {
    Map<String, dynamic>? json = value as Map<String, dynamic>?;
    if (json == null) {
      return;
    }

    final guess = HangmanPlayerGuessMessage.fromJson(json);

    print("${guess.nickname} guessed ${guess.letter}");

    ref.read(_gameProvider.notifier).tryLetter(guess.letter);
  }

  void _onPlayersData(dynamic value) {
    Map<String, dynamic>? json = value as Map<String, dynamic>?;
    if (json == null) {
      return;
    }

    final player = HangmanPlayerJoinMessage.fromJson(json);

    print("${player.nickname} ${player.leaving ? "left" : "joined"}");

    if (player.leaving) {
      _players.remove(player.nickname);
      _goToLobby();
    }
    else {
      if (!_players.contains(player.nickname)) {
        _players.add(player.nickname);
        if (player.nickname != _nickname) {
        _sendJoinMessage(_nickname);
      }
        _goToLobby();
      }
      
    }

   


    
  }

  
  void _onDataGuest(HangmanMqttEvent event) {
    final topic = HangmanTopic.fromString(event.topic);

    if (topic == null) {
      return;
    }

    switch(topic) {
      case HangmanTopic.players:
        _onPlayersData(event.value);
      case HangmanTopic.state:
        _onGameStateData(event.value);
      default:
        break;
    }
  }

  void _onGameStateData(dynamic value) {
    Map<String, dynamic>? json = value as Map<String, dynamic>?;
    if (json == null) {
      return;
    }

    final gameState = HangmanGameState.fromJson(json);

    state = gameState;
  }

  void _pushData<T extends HangmanMessage>(String topic, T value) {
    _mqtt.pushData(topic, value.toJson());
  }

}
