
import 'hangman_mqtt_base.dart';
import 'package:mqtt5_client/mqtt5_browser_client.dart';
import 'package:mqtt5_client/mqtt5_client.dart';

class HangmanMqttImpl extends HangmanMqttBase {
  HangmanMqttImpl(super.hostName, super.port, super.identifier, super.willTopic, super.willMessage);

  @override
  MqttClient create() {
     final client = MqttBrowserClient.withPort(hostName, identifier, port);

    client.websocketProtocols = ['mqtt'];

    client.logging(on: true);

    client.autoReconnect = true;

    client.keepAlivePeriod = 20;

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;

    
   client.connectionMessage = connectionMessage();
    //client.securityContext = SecurityContext.defaultContext;

    return client;
  }

  
}