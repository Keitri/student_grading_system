import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/auth/auth_bloc.dart';
import 'package:student_grading_app/core/bloc/login/login_bloc.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // Text Controllers
  final _tcMobileNumber = TextEditingController();
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

  Widget get _space => const SizedBox(height: 10);

  Widget _loginButton(BuildContext context, LoginState state) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor)),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(StartLoginEvent(
                  mobileNumber: _tcMobileNumber.text,
                  password: _tcPassword.text));
            },
            child: state is LoginLoading
                ? const CupertinoActivityIndicator()
                : Text(AppText.login.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))));
  }

  Widget _errorMessage(LoginState state) {
    return state is LoginError
        ? Text(state.errorMessage, style: const TextStyle(color: Colors.red))
        : Container();
  }

  Widget _body(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Card(
                elevation: 5.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // App Name
                        const Text(
                          AppText.appName,
                          style: TextStyle(fontSize: 30),
                        ),
                        _space,
                        _space,
                        // Phone Input
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: _textDecoration(
                              context: context, label: AppText.mobileNumber),
                          controller: _tcMobileNumber,
                        ),
                        _space,
                        // Password Input
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: _textDecoration(
                              context: context, label: AppText.password),
                          controller: _tcPassword,
                        ),
                        _space,
                        // Login Button
                        BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                          if (state is LoginSuccess) {
                            // Authenticate User
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthenticateEvent(
                                    currentUser: state.currentUser));
                          }
                        }, builder: (context, state) {
                          return Column(children: [
                            _loginButton(context, state),
                            _space,
                            _errorMessage(state)
                          ]);
                        })
                      ],
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor, body: _body(context));
  }
}
