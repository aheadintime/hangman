import 'package:flutter/material.dart';

class HangmanKeyboard extends StatelessWidget {
  final List<String> characters;
  final List<String> disabledCharacters;
  final void Function(String character) onKeyPressed;

  const HangmanKeyboard({super.key, required this.characters, required this.disabledCharacters, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: characters.map((character) {
        return HangmanKeyboardKey(character: character, isEnabled: !disabledCharacters.contains(character), onKeyPressed: onKeyPressed,);
      }).toList()
    );
  }

}

class HangmanKeyboardKey extends StatelessWidget {
  final String character;
    final double size;
    final bool isEnabled;
    final void Function(String character) onKeyPressed;

  const HangmanKeyboardKey({super.key, required this.character, this.size = 48, required this.isEnabled, required this.onKeyPressed});
  
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: !isEnabled ? null : () {
      onKeyPressed(character);
    },child: 
    SizedBox.square(
      dimension: size,
      child: Container(
        decoration: BoxDecoration(border: Border.all(
          color: isEnabled ? Colors.black : Colors.blueGrey.withAlpha(128)
        ), borderRadius: BorderRadius.circular(6)),
        child: Center(child: Text(character)),
      ),
    ),
    );
    
  }
  
}