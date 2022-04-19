import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/view/validators/validator.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/button.dart';
import 'package:student_grading_app/view/widgets/textinputform.dart';
import 'package:student_grading_app/view/widgets/widget.dart';
import 'package:uuid/uuid.dart';

import '../../core/bloc/student/student_bloc.dart';
import '../../core/model/student.dart';

class StudentForm extends StatelessWidget {
  StudentForm({required this.bloc, Key? key}) : super(key: key);

  final _tcFirstName = TextEditingController();
  final _tcLastName = TextEditingController();
  final _tcMobileNumber = TextEditingController();
  final _tcParentMobileNumber = TextEditingController();
  final _tcDefaultPass = TextEditingController();
  final colorAccent = Colors.redAccent;

  final _formKey = GlobalKey<FormState>();

  final StudentBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppText.newStudent),
            centerTitle: true,
            backgroundColor: colorAccent),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  // First Name
                  TextInput(
                      validator: Validator.requiredValidator,
                      label: AppText.firstName,
                      controller: _tcFirstName),
                  space,
                  // Last Name
                  TextInput(
                      validator: Validator.requiredValidator,
                      label: AppText.lastName,
                      controller: _tcLastName),
                  space,
                  // Mobile Number
                  TextInput(
                      validator: Validator.requiredValidator,
                      label: AppText.mobileNumber,
                      controller: _tcMobileNumber,
                      inputType: TextInputType.phone),
                  space,
                  // Parent Mobile Number
                  TextInput(
                    validator: Validator.requiredValidator,
                    label: AppText.parentMobileNumber,
                    controller: _tcParentMobileNumber,
                    inputType: TextInputType.phone,
                  ),
                  space,
                  // Default Password
                  TextInput(
                      validator: Validator.passwordValidator,
                      label: AppText.defaultPass,
                      controller: _tcDefaultPass,
                      obscureText: true,
                      inputType: TextInputType.visiblePassword),
                  space,
                  BlocConsumer<StudentBloc, StudentState>(
                      bloc: bloc,
                      listener: (context, state) {
                        // Hide Scaffold Messenger
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        if (state is NewStudentError) {
                          // Show Error Message
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.errorMessage),
                              backgroundColor: Colors.red));
                        }

                        if (state is NewStudentSaved) {
                          // Show Success Message
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(AppText.studentSaved),
                                  backgroundColor: Colors.green));
                        }
                      },
                      builder: (_, state) {
                        return PrimaryButton(
                            text: AppText.save,
                            isLoading: state is NewStudentSaving,
                            color: colorAccent,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Hide Keyboard
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // Try Save New Faculty
                                bloc.add(SaveNewStudentUser(
                                    newUser: StudentModel(
                                        id: const Uuid().v4(),
                                        mobileNumber: _tcMobileNumber.text,
                                        firstName: _tcFirstName.text,
                                        lastName: _tcLastName.text,
                                        parentMobileNumber:
                                            _tcParentMobileNumber.text,
                                        defaultPassword: _tcDefaultPass.text)));
                              }
                            });
                      })
                ]))));
  }
}
