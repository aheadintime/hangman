import 'hangman_mqtt_base.dart';

class HangmanMqttImpl extends HangmanMqttBase {
  HangmanMqttImpl(super.hostName, super.port, super.identifier, super.willTopic, super.willMessage);

  
  @override
  Future<bool> begin() {
    // TODO: implement begin
    throw UnimplementedError();
  }

  @override
  void pushData(String topic, data) {
    // TODO: implement pushData
  }

  Stream streamForTopic(String topic) {
    // TODO: implement streamForTopic
    throw UnimplementedError();
  }

}