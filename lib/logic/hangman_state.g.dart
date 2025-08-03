// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hangman_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HangmanGameState _$HangmanGameStateFromJson(
  Map<String, dynamic> json,
) => HangmanGameState(
  status: $enumDecode(_$HangmanGameStatusEnumMap, json['status']),
  maskedWord:
      (json['maskedWord'] as List<dynamic>).map((e) => e as String?).toList(),
  triedLetters:
      (json['triedLetters'] as List<dynamic>).map((e) => e as String).toList(),
  errors: (json['errors'] as num).toInt(),
);

Map<String, dynamic> _$HangmanGameStateToJson(HangmanGameState instance) =>
    <String, dynamic>{
      'status': _$HangmanGameStatusEnumMap[instance.status]!,
      'maskedWord': instance.maskedWord,
      'triedLetters': instance.triedLetters,
      'errors': instance.errors,
    };

const _$HangmanGameStatusEnumMap = {
  HangmanGameStatus.playing: 'playing',
  HangmanGameStatus.win: 'win',
  HangmanGameStatus.lost: 'lost',
};
