import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mqtt5_client/mqtt5_client.dart';

import 'hangman_mqtt_def.dart';


class HangmanMqttBase extends HangmanMqttDef {

  late MqttClient client;
  late ConnectCallback onConnected;
  late ConnectCallback onDisconnected;

  final Map<String, StreamController<HangmanMqttEvent>> topicStreams = {};

  final String? willTopic;
  final String? willMessage;

  HangmanMqttBase(super.hostName, super.port, super.identifier, this.willTopic, this.willMessage);
  
   @override
     MqttConnectMessage connectionMessage() {
    return _connectionMessage(willTopic, willMessage);
   }

  MqttConnectMessage _connectionMessage(String? willTopic, String? willMessage) {
     MqttConnectMessage message = MqttConnectMessage()
        .withClientIdentifier(identifier)
        
        .startClean();

   
    if (willTopic != null && willMessage != null) {
      final properties = MqttWillProperties();
      properties.willDelayInterval = 5;
      properties.payloadFormatIndicator = true;
      properties.messageExpiryInterval = 0;
      properties.contentType = "";

      //final msg = MqttUtf8Encoding().toUtf8(willMessage);

      final builder = MqttPayloadBuilder();
    builder.addString(willMessage);

      message = message
          .will()
          .withWillTopic(willTopic)
          .withWillPayload(builder.payload!)
          .withWillQos(MqttQos.atMostOnce)
          .withWillProperties(properties);
    }
  
    return message;
  }

  @override
  Future<bool> begin() async {
   
    client = create();
   
    try {
      await client.connect();
    } on Exception catch (e) {
      
      if (kDebugMode) {
        print(e);
      }

      client.disconnect();
      return false;
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.updates.listen(onData);
      return true;
    } else {
      client.disconnect();
      return false;
    }
  }

  void onData(List<MqttReceivedMessage<MqttMessage>> events) {
    for (var event in events) {
      if (topicStreams.containsKey(event.topic)) {
        final stream = topicStreams[event.topic]!;
        if (!stream.isPaused || !stream.isClosed) {
          stream.add(
            HangmanMqttEvent(
              topic: event.topic ?? "", 
              value: decodeMsg(event.payload)
              )
            );
        }
      }
    }
  }

  dynamic decodeMsg(MqttMessage payload) {
    final msg = payload as MqttPublishMessage;
    final str = utf8.decode(msg.payload.message!.toList(growable: false));
    return json.decode(str);
  }

  @override
  void pushData(String topic, data) {
    final builder = MqttPayloadBuilder();
    builder.addString(json.encode(data));
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  @override
  Stream<HangmanMqttEvent> streamForTopics(List<String> topics) {
   late StreamController<HangmanMqttEvent> controller;
    
    controller = StreamController(
      onListen: () {
        if (client.connectionStatus!.state != MqttConnectionState.connected) {
          controller.close();
          return;
        }
        for (var topic in topics) {
          topicStreams[topic] = controller;
          client.subscribe(topic, MqttQos.atMostOnce);
        }
        
      },
      onCancel: () {
        for (var topic in topics) {
        topicStreams.remove(topic);
        }
      },
    );

    return controller.stream;
  }
  
  @override
  MqttClient create() {
    throw UnimplementedError();
  }
}

class HangmanMqttEvent {
  String topic;
  dynamic value;

  HangmanMqttEvent({
    required this.topic,
    required this.value
  });

}