import 'package:flutter/material.dart';

class HangmanText extends StatelessWidget {
  final List<String?> characters;

  const HangmanText({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: characters.map((character) {
        return HangmanCharacterField(character: character,);
      }).toList(),
    );
  }

}

class HangmanCharacterField extends StatelessWidget {
  final double size;
  final String? character;

  const HangmanCharacterField({super.key, this.character, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Container(
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(6)),
        child: Center(child: Text(character ?? "")),
      ),
    );
  }

}