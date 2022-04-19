import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/auth/auth_bloc.dart';
import 'package:student_grading_app/core/bloc/login/login_bloc.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/button.dart';
import 'package:student_grading_app/view/widgets/textinputform.dart';
import 'package:student_grading_app/view/widgets/widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // Text Controllers
  final _tcMobileNumber = TextEditingController();
  final _tcPassword = TextEditingController();

  Widget _loginButton(BuildContext context, bool isLoading) {
    return PrimaryButton(
        text: AppText.login,
        isLoading: isLoading,
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(StartLoginEvent(
              mobileNumber: _tcMobileNumber.text, password: _tcPassword.text));
        });
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
                        space,
                        space,
                        // Phone Input
                        TextInput(
                            inputType: TextInputType.phone,
                            label: AppText.mobileNumber,
                            controller: _tcMobileNumber),
                        space,
                        // Password Input
                        TextInput(
                          inputType: TextInputType.visiblePassword,
                          obscureText: true,
                          label: AppText.password,
                          controller: _tcPassword,
                        ),
                        space,
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
                            _loginButton(context, state is LoginLoading),
                            space,
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
