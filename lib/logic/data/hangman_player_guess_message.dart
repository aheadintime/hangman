import 'hangman_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hangman_player_guess_message.g.dart';

@JsonSerializable()
class HangmanPlayerGuessMessage implements HangmanMessage {
  
  final String nickname;
  final String letter;

  HangmanPlayerGuessMessage({required this.nickname, required this.letter});

  factory HangmanPlayerGuessMessage.fromJson(Map<String, dynamic> json) => _$HangmanPlayerGuessMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HangmanPlayerGuessMessageToJson(this);
}