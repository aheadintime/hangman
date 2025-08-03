import 'hangman_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hangman_player_join_message.g.dart';

@JsonSerializable()
class HangmanPlayerJoinMessage implements HangmanMessage {
  
  final bool leaving;
  final String nickname;

  HangmanPlayerJoinMessage({required this.nickname, required this.leaving});

  factory HangmanPlayerJoinMessage.fromJson(Map<String, dynamic> json) => _$HangmanPlayerJoinMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HangmanPlayerJoinMessageToJson(this);
}