import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // Text Controllers
  final _tcPhoneNumber = TextEditingController();
  final _tcPassword = TextEditingController();

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

  Widget get _space => Container(height: 10);

  Widget _body(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    // Phone Input
                    TextField(
                      decoration: _textDecoration(
                          context: context, label: "Mobile Number"),
                      controller: _tcPhoneNumber,
                    ),
                    _space,
                    // Password Input
                    TextField(
                      decoration:
                          _textDecoration(context: context, label: "Password"),
                      controller: _tcPassword,
                    )
                    // Login Button

                    // Forgot Password

                    // Register Button
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }
}
