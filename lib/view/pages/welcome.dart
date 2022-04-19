import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/app/app_bloc.dart';
import 'package:student_grading_app/core/bloc/auth/auth_bloc.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  TextStyle get _textStyle => const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);

  Widget _mainContent(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).primaryColor,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(AppText.appName, style: _textStyle),
                  Container(height: 10),
                  const CircularProgressIndicator(color: Colors.white)
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
        listener: (_, state) {
          if (state is AppLoaded) {
            // Start Auto Login
            BlocProvider.of<AuthBloc>(context).add(AutoLoginEvent());
          }
        },
        child: _mainContent(context));
  }
}
