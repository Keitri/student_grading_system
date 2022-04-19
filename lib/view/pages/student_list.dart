import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.students),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
