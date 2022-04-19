import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/auth/auth_bloc.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/widget.dart';

import '../validators/validator.dart';
import '../widgets/button.dart';
import '../widgets/textinputform.dart';

class ChangePasswordDialog extends StatelessWidget {
  final AuthBloc bloc;

  ChangePasswordDialog({required this.bloc, Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _tcNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
            height: 250,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey,
                  title: const Text(AppText.changePassword),
                  centerTitle: true,
                ),
                body: BlocListener<AuthBloc, AuthState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is AuthPasswordChangeError) {
                        // Show Snackbar Error
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.errorMessage),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Center(
                        child: Form(
                            key: _formKey,
                            child: ListView(shrinkWrap: true, children: [
                              space,
                              TextInput(
                                  validator: Validator.passwordValidator,
                                  label: AppText.newPassword,
                                  controller: _tcNewPassword,
                                  obscureText: true,
                                  inputType: TextInputType.visiblePassword),
                              space,
                              PrimaryButton(
                                  text: AppText.confirm,
                                  isLoading: false,
                                  color: Colors.grey,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Hide Keyboard
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      bloc.add(ChangePassword(
                                          newPassword: _tcNewPassword.text));
                                    }
                                  })
                            ])),
                      ),
                    )))));
  }
}
