import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/auth/auth_bloc.dart';
import 'package:student_grading_app/core/model/faculty.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/bloc/grade/grade_bloc.dart';

class GradeListPage extends StatelessWidget {
  final colorAccent = Colors.green;
  final GradeBloc bloc;

  const GradeListPage({required this.bloc, Key? key}) : super(key: key);

  // Add Button
  Widget _addButton(BuildContext context) {
    // Show Add for Faculty User Only
    bool isFaculty = false;
    final authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is Authenticated) {
      isFaculty = authState.currentUser is FacultyModel;
    }
    return isFaculty
        ? Align(
            alignment: Alignment.bottomRight,
            child: Container(
                margin: const EdgeInsets.all(20),
                child: FloatingActionButton(
                  backgroundColor: colorAccent,
                  onPressed: () {},
                  child: const Center(child: Icon(Icons.add)),
                )))
        : Container();
  }

  // No Grade
  Widget _noGrade() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(AppText.noGrade,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Container(height: 10),
              const Text(AppText.requestGrade,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppText.grades),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Stack(children: [_noGrade(), _addButton(context)]));
  }
}
