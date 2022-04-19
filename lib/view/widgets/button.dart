import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color? color;
  const PrimaryButton(
      {required this.text,
      required this.isLoading,
      required this.onPressed,
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    color ?? Theme.of(context).primaryColor)),
            onPressed: onPressed,
            child: isLoading
                ? const CupertinoActivityIndicator()
                : Text(text.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))));
  }
}
