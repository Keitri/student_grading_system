import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextInputType inputType;
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const TextInput(
      {required this.label,
      required this.controller,
      Key? key,
      this.validator,
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
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0)),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0)),
      labelText: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: inputType,
      obscureText: obscureText,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: _textDecoration(context: context, label: label),
    );
  }
}
