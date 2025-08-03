// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hangman_player_join_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HangmanPlayerJoinMessage _$HangmanPlayerJoinMessageFromJson(
  Map<String, dynamic> json,
) => HangmanPlayerJoinMessage(
  nickname: json['nickname'] as String,
  leaving: json['leaving'] as bool,
);

Map<String, dynamic> _$HangmanPlayerJoinMessageToJson(
  HangmanPlayerJoinMessage instance,
) => <String, dynamic>{
  'leaving': instance.leaving,
  'nickname': instance.nickname,
};
