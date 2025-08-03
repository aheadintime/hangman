import 'package:flutter/material.dart';
import 'package:hangman/logic/hangman_provider.dart';
import 'package:hangman/logic/hangman_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'hangman_keyboard.dart';
import 'hangman_man.dart';
import 'hangman_text.dart';

class HangmanGame extends ConsumerWidget {
  final HangmanGameState state;

  const HangmanGame({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final keyboardCharacters =
      "qwertyuiopasdfghjklzxcvbnm ".toUpperCase().characters.toList();
    final isGuest = ref.read(hangmanProvider.notifier).isGuest();
    final nickname = ref.read(hangmanProvider.notifier).nickname();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            Divider(),
            Text(nickname),
            Divider(),
                  Text(
                    state.status.statusAsString,
                  ),
      
            Divider(),
              HangmanMan(errors: state.errors),
                  Divider(),

                  HangmanText(characters:  state.maskedWord),
      
                  Divider(),
              if (isGuest)    
              Column(
                spacing: 8,
                children: [
                 

                  
                  HangmanKeyboard(
                    characters: keyboardCharacters,
                    disabledCharacters:  state.triedLetters,
                    onKeyPressed: (character) {
                      ref.read(hangmanProvider.notifier).tryLetter(character);
                    },  
                  ),
      
                  Divider(),
      
                  
                ],
              ),

              if(!isGuest)
                HangmanKeyboardKey(character: "RESET", isEnabled: true, onKeyPressed: (_) {
                  ref.read(hangmanProvider.notifier).goToLobby();
                })
          ],
        ),
      ),
    );
  }

}

extension on HangmanGameStatus {
  String get statusAsString {
    switch(this) {
      case HangmanGameStatus.playing:
        return "🥇LET'S PLAY🥇";
      case HangmanGameStatus.win:
        return "✅CONGRATULATIONS✅";
      case HangmanGameStatus.lost:
        return "🆘YOU DIED🆘";
    }
  }
}