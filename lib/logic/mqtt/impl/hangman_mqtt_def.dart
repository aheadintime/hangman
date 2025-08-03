
import 'package:mqtt5_client/mqtt5_client.dart';

abstract class HangmanMqttDef {
  final String hostName;
  final int port;
  final String identifier;

  HangmanMqttDef(this.hostName, this.port, this.identifier);

  MqttClient create();
  MqttConnectMessage connectionMessage();

  Future<bool> begin();
  Stream<dynamic> streamForTopics(List<String> topic);
  void pushData(String topic, dynamic data);
}