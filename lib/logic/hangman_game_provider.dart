import 'package:flutter/material.dart';
import 'hangman_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hangman_game_provider.g.dart';

@Riverpod()
class HangmanGame extends _$HangmanGame {
  late String _word;
  
  @override
  HangmanGameState build(String word) {
    _word = word;
    return HangmanGameState(status: HangmanGameStatus.playing, maskedWord: List.filled(word.length, null), triedLetters: [], errors: 0);
  }

  void tryLetter(String letter) {
    state = state.tryLetter(_word, letter);
  }
 

}

extension on HangmanGameState {
  HangmanGameState tryLetter(String word, String letter) {
    if (!word.contains(letter)) {
      return HangmanGameState(status: _newStatus(errors + 1, maskedWord), maskedWord: maskedWord, triedLetters: triedLetters, errors: errors + 1);
    }

    if (triedLetters.contains(letter)) {
      return HangmanGameState(status: status, maskedWord: maskedWord, triedLetters: triedLetters, errors: errors);
    }

    final letterIndexes = word.characters.toList().indexed.where((indexed) {
      return indexed.$2 == letter;
    }).map((indexed) {
      return indexed.$1;
    }).toList();

    var newMaskedWord = maskedWord;

    for (var index in letterIndexes) {
      newMaskedWord[index] = letter;
    }

    return HangmanGameState(status: _newStatus(errors, newMaskedWord), maskedWord: newMaskedWord, triedLetters: triedLetters + [letter], errors: errors);
  }

  HangmanGameStatus _newStatus(int errors, List<String?> maskedWord) {
    if (errors > 5) {
      return HangmanGameStatus.lost;
    }

    if (!maskedWord.contains(null)) {
      return HangmanGameStatus.win;
    }

    return HangmanGameStatus.playing;
  }
}