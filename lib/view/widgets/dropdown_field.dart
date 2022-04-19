import 'package:flutter/material.dart';

import 'dropdown_controller.dart';

class DropdownInput extends StatelessWidget {
  final String label;
  final DropdownController controller;
  final FormFieldValidator<String>? validator;
  final VoidCallback onPressed;

  const DropdownInput(
      {required this.label,
      required this.controller,
      required this.onPressed,
      this.validator,
      Key? key})
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
        floatingLabelBehavior: FloatingLabelBehavior.auto);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextFormField(
        validator: validator,
        readOnly: true,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: _textDecoration(context: context, label: label),
      ),
      GestureDetector(
          onTap: onPressed,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              color: Colors.transparent,
              child: Row(children: [
                Expanded(child: Container()),
                const Icon(Icons.search, color: Colors.grey)
              ])))
    ]);
  }
}
