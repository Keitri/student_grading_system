import 'package:flutter/material.dart';
import 'package:student_grading_app/view/pages/routes.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class RegistrarHome extends StatelessWidget {
  const RegistrarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _faculties(context),
      _students(context),
      _subjects(context),
      _grades(context)
    ]);
  }

  Widget _itemCard(String title, Color color, {int count = 0}) {
    return Card(
        color: color,
        child: Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                Text(
                  count.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ])
            ])));
  }

  // Subjects
  Widget _subjects(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.subjectList),
        child: _itemCard(AppText.subjects, Colors.orangeAccent));
  }

  // Faculty
  Widget _faculties(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.facultyList),
        child: _itemCard(AppText.faculties, Colors.deepPurpleAccent));
  }

  // Students
  Widget _students(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.studentList),
        child: _itemCard(AppText.students, Colors.redAccent));
  }

  // Grades
  Widget _grades(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.gradeList),
        child: _itemCard(AppText.grades, Colors.green));
  }
}
