import 'package:flutter/material.dart';

class HangmanTextfield extends StatelessWidget {
  
  final String? hint;
  final TextEditingController? controller;
  const HangmanTextfield({super.key, this.controller, this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide()
        )
      ),
      controller: controller,
    );
  }

}