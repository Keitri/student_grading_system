import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextInputType inputType;
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const TextInput(
      {required this.label,
      required this.controller,
      Key? key,
      this.inputType = TextInputType.text,
      this.obscureText = false})
      : super(key: key);

  InputDecoration _textDecoration(
      {required BuildContext context, required String label}) {
    return InputDecoration(
      isDense: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText,
      controller: controller,
      decoration: _textDecoration(context: context, label: label),
    );
  }
}
