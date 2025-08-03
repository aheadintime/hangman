import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hangman/logic/hangman_provider.dart';
import 'package:hangman/ui/components/hangman_keyboard.dart';
import 'package:hangman/ui/components/hangman_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HangmanConfig extends HookConsumerWidget {
  const HangmanConfig({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttUrl = useTextEditingController(
      text: ref.read(hangmanProvider.notifier).getHostname(),
    );
    final mqttPort = useTextEditingController(
      text: ref.read(hangmanProvider.notifier).getPort().toString(),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            Text("MQTT URL"),

            HangmanTextfield(controller: mqttUrl),

            Divider(),

            Text("MQTT PORT"),

            HangmanTextfield(controller: mqttPort),

            Divider(),

            HangmanKeyboardKey(
              character: "SAVE",
              isEnabled: true,
              onKeyPressed: (_) {
                ref.read(hangmanProvider.notifier).setHostname(mqttUrl.text);
                int? port = int.tryParse(mqttPort.text);

                if (port != null) {
                  ref.read(hangmanProvider.notifier).setPort(port);
                }

                ref.read(hangmanProvider.notifier).goToHome();
              },
            ),
          ],
        ),
      ),
    );
  }
}
