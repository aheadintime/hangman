import 'package:flutter/widgets.dart';
import 'package:hangman/logic/hangman_provider.dart';
import 'package:hangman/logic/hangman_state.dart';
import 'package:hangman/ui/components/hangman_config.dart';
import 'package:hangman/ui/components/hangman_game.dart';
import 'package:hangman/ui/components/hangman_lobby.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/hangman_home.dart';

class Game extends HookConsumerWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hangmanProvider);

    if (state is HangmanHomeState) {
      return HangmanHome();
    }

    if (state is HangmanLobbyState) {
      return HangmanLobby(state: state,);
    }

    if (state is HangmanGameState) {
      return HangmanGame(state: state);
    }

    if (state is HangmanConfigState) {
      return HangmanConfig();
    }

    return Container();
  }

}