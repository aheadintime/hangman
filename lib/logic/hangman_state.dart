import 'package:hangman/logic/data/hangman_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hangman_state.g.dart';


abstract class HangmanState {

}

class HangmanConfigState extends HangmanState {

}

class HangmanHomeState extends HangmanState {

}

class HangmanLobbyState extends HangmanState {
  final List<String> players;

  HangmanLobbyState({required this.players});

}

@JsonSerializable()
class HangmanGameState extends HangmanState implements HangmanMessage {
  final HangmanGameStatus status;
  final List<String?> maskedWord;
  final List<String> triedLetters;
  final int errors;

  HangmanGameState({required this.status, required this.maskedWord, required this.triedLetters, required this.errors});
  
  @override
  Map<String, dynamic> toJson() => _$HangmanGameStateToJson(this);

  factory HangmanGameState.fromJson(Map<String, dynamic> json) => _$HangmanGameStateFromJson(json);
}

enum HangmanGameStatus {
  playing,
  win,
  lost

}