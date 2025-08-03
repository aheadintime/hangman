import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hangman/logic/hangman_provider.dart';
import 'package:hangman/ui/components/hangman_keyboard.dart';
import 'package:hangman/ui/components/hangman_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HangmanHome extends HookConsumerWidget {
  const HangmanHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameController = useTextEditingController();
    final roomIdController = useTextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            HangmanTextfield(controller: nicknameController, hint: "Nickname",),
            HangmanTextfield(controller: roomIdController, hint: "Room Id",),
            HangmanKeyboardKey(character: "NEW", isEnabled: true, onKeyPressed: (_) {
              ref.read(hangmanProvider.notifier).newRoom(nicknameController.text);
            }),
            HangmanKeyboardKey(character: "JOIN", isEnabled: true, onKeyPressed: (_) {
              ref.read(hangmanProvider.notifier).joinRoom(nicknameController.text, roomIdController.text);
            }),
            HangmanKeyboardKey(character: "CFG", isEnabled: true, onKeyPressed: (_) {
              ref.read(hangmanProvider.notifier).openConfig();
            }),
          ],
        ),
      ),
    );
  }

}