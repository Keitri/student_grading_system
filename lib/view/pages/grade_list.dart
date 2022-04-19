import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class GradeListPage extends StatelessWidget {
  const GradeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.grades),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
    );
  }
}
