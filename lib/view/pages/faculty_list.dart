import 'package:flutter/material.dart';
import 'package:student_grading_app/view/pages/faculty_form.dart';
import 'package:student_grading_app/view/transitions/transitions.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class FacultyListPage extends StatelessWidget {
  const FacultyListPage({Key? key}) : super(key: key);

  final colorAccent = Colors.deepPurpleAccent;

  // Add Button
  Widget _addButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            margin: const EdgeInsets.all(20),
            child: FloatingActionButton(
              backgroundColor: colorAccent,
              onPressed: () {
                Navigator.of(context)
                    .push(SlideRightRoute(page: FacultyForm()));
              },
              child: const Center(child: Icon(Icons.add)),
            )));
  }

  // No Faculty Text
  Widget _noFaculty() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(AppText.noFaculty,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Container(height: 10),
              const Text(AppText.addFaculty,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppText.faculties),
            centerTitle: true,
            backgroundColor: colorAccent),
        body: Stack(children: [_noFaculty(), _addButton(context)]));
  }
}
