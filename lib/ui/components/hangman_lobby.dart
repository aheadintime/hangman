import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hangman/logic/hangman_provider.dart';
import 'package:hangman/logic/hangman_state.dart';
import 'package:hangman/ui/components/hangman_keyboard.dart';
import 'package:hangman/ui/components/hangman_text.dart';
import 'package:hangman/ui/components/hangman_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HangmanLobby extends HookConsumerWidget {
  final HangmanLobbyState state;
  
  const HangmanLobby({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final word = useTextEditingController();

     final isGuest = ref.read(hangmanProvider.notifier).isGuest();
    final myNickname = ref.read(hangmanProvider.notifier).nickname();
    final roomId = ref.read(hangmanProvider.notifier).roomId();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            Text("Room Id"),

            HangmanText(characters: roomId.characters.toList()),

            Divider(),

            if(!isGuest)
              HangmanTextfield(controller: word, hint: "GAME WORD",),
        
            if (!isGuest)
              HangmanKeyboardKey(character: "START", isEnabled: true, onKeyPressed: (_) {
                ref.read(hangmanProvider.notifier).startGame(word.text);
              }),        
        
            if (isGuest) 
              Text("WAIT FOR MASTER"),

            Column(
              children: state.players.map((nickname) {
                return Text(nickname, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: myNickname == nickname ? FontWeight.bold : FontWeight.normal),);
              }).toList(),
            )
          ],
        ),
      ),
    );

  }

}