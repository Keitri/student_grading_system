import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/button.dart';
import 'package:student_grading_app/view/widgets/textinputform.dart';
import 'package:student_grading_app/view/widgets/widget.dart';

class FacultyForm extends StatelessWidget {
  FacultyForm({Key? key}) : super(key: key);

  final _tcFirstName = TextEditingController();
  final _tcLastName = TextEditingController();
  final _tcMobileNumber = TextEditingController();
  final _tcDefaultPass = TextEditingController();
  final colorAccent = Colors.deepPurpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppText.newFaculty),
            centerTitle: true,
            backgroundColor: colorAccent),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              // First Name
              TextInput(label: AppText.firstName, controller: _tcFirstName),
              space,
              // Last Name
              TextInput(label: AppText.lastName, controller: _tcLastName),
              space,
              // Mobile Number
              TextInput(
                  label: AppText.mobileNumber,
                  controller: _tcMobileNumber,
                  inputType: TextInputType.phone),
              space,
              // Default Password
              TextInput(
                  label: AppText.defaultPass,
                  controller: _tcDefaultPass,
                  obscureText: true,
                  inputType: TextInputType.visiblePassword),
              space,
              PrimaryButton(
                  text: AppText.save,
                  isLoading: false,
                  color: colorAccent,
                  onPressed: () {})
            ])));
  }
}
