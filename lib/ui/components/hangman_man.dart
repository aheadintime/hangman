import 'package:flutter/material.dart';
import 'hangman_text.dart';

class HangmanMan extends StatelessWidget {
  final int errors;

  const HangmanMan({super.key, required this.errors});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              (errors <= 0)
                  ? [HangmanCharacterField(character: "")]
                  : [HangmanCharacterField(character: "👦🏼")],
        ), //head
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _torso(),
        ),
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _legs(),
        ), //legs
      ],
    );
  }

  List<Widget> _torso() {
    if (errors <= 1) {
      return [
        HangmanCharacterField(character: ""),
        HangmanCharacterField(character: ""),
        HangmanCharacterField(character: ""),
      ];
    }

    if (errors <= 2) {
      return [
        HangmanCharacterField(character: "💪🏼"),
        HangmanCharacterField(character: ""),
        HangmanCharacterField(character: ""),
      ];
    }

    if (errors <= 3) {
      return [
        HangmanCharacterField(character: "💪🏼"),
        HangmanCharacterField(character: "👕"),
        HangmanCharacterField(character: ""),
      ];
    }

    return [
      HangmanCharacterField(character: "💪🏼"),
      HangmanCharacterField(character: "👕"),
      HangmanCharacterField(character: "💪🏼"),
    ];
  }

  List<Widget> _legs() {
    if (errors <= 4) {
      return [
        HangmanCharacterField(character: ""),
        HangmanCharacterField(character: ""),
      ];
    }

    if (errors <= 5) {
      return [
        HangmanCharacterField(character: "🦵🏼"),
        HangmanCharacterField(character: ""),
      ];
    }

    return [
      HangmanCharacterField(character: "🦵🏼"),
      HangmanCharacterField(character: "🦵🏼"),
    ];
  }
}
