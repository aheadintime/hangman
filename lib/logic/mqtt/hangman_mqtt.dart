import 'package:hangman/logic/mqtt/impl/hangman_mqtt_base.dart';

import 'impl/hangman_mqtt_stub.dart'
    if (dart.library.io) 'impl/hangman_mqtt_io.dart'
    if (dart.library.html) 'impl/hangman_mqtt_web.dart';
    
import 'package:mqtt5_client/mqtt5_client.dart';

class HangmanMqtt {
  final HangmanMqttImpl _mqtt;

  ConnectCallback get onConnected {
    return _mqtt.onConnected;
  }

  set onConnected(ConnectCallback value) {
    _mqtt.onConnected = value;
  }

  ConnectCallback get onDisconnected {
    return _mqtt.onDisconnected;
  }

  set onDisconnected(ConnectCallback value) {
    _mqtt.onDisconnected = value;
  }

  HangmanMqtt(String hostName, int port, String identifier, String? willTopic, String? willMessage)
      : _mqtt = HangmanMqttImpl(hostName, port, identifier, willTopic, willMessage);

  Future<bool> begin() {
    return _mqtt.begin();
  }

  void pushData(String topic, data) {
    _mqtt.pushData(topic, data);
  }

  Stream<HangmanMqttEvent> streamForTopics(List<String> topics) {
    return _mqtt.streamForTopics(topics);
  }
}
