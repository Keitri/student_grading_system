import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class SubjectListPage extends StatelessWidget {
  const SubjectListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppText.subjects),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent),
    );
  }
}
