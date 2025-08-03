import 'dart:io';

import 'hangman_mqtt_base.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';


class HangmanMqttImpl extends HangmanMqttBase {
  HangmanMqttImpl(super.hostName, super.port, super.identifier, super.willTopic, super.willMessage);

 
  @override
  MqttClient create() {
    final client = MqttServerClient.withPort(hostName, identifier, port);
    client.useWebSocket = true;
    client.websocketProtocols = ['mqtt'];

    client.logging(on: false);

    client.autoReconnect = true;

    client.keepAlivePeriod = 20;

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;

    client.connectionMessage = connectionMessage();
    client.securityContext = SecurityContext.defaultContext;

    return client;
  }
}
