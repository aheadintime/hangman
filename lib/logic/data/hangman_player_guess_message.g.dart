// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hangman_player_guess_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HangmanPlayerGuessMessage _$HangmanPlayerGuessMessageFromJson(
  Map<String, dynamic> json,
) => HangmanPlayerGuessMessage(
  nickname: json['nickname'] as String,
  letter: json['letter'] as String,
);

Map<String, dynamic> _$HangmanPlayerGuessMessageToJson(
  HangmanPlayerGuessMessage instance,
) => <String, dynamic>{
  'nickname': instance.nickname,
  'letter': instance.letter,
};
