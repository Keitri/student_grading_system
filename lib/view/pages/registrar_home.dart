import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/faculty/faculty_bloc.dart';
import 'package:student_grading_app/view/pages/faculty_list.dart';
import 'package:student_grading_app/view/pages/grade_list.dart';
import 'package:student_grading_app/view/pages/student_list.dart';
import 'package:student_grading_app/view/pages/subject_list.dart';
import 'package:student_grading_app/view/transitions/transitions.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/bloc/student/student_bloc.dart';

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

  Widget _itemCard(bool isLoading, String title, Color color, {int count = 0}) {
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
                !isLoading
                    ? Text(
                        count.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    : const CupertinoActivityIndicator()
              ])
            ])));
  }

  // Subjects
  Widget _subjects(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(SlideRightRoute(page: SubjectListPage())),
        child: _itemCard(false, AppText.subjects, Colors.orangeAccent));
  }

  // Faculty
  Widget _faculties(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(SlideRightRoute(
            page:
                FacultyListPage(bloc: BlocProvider.of<FacultyBloc>(context)))),
        child: BlocBuilder<FacultyBloc, FacultyState>(
            buildWhen: (previous, current) =>
                current is FacultyListLoaded || current is FacultyLoading,
            builder: (_, state) => _itemCard(state is FacultyLoading,
                AppText.faculties, Colors.deepPurpleAccent,
                count: state is FacultyListLoaded ? state.data.length : 0)));
  }

  // Students
  Widget _students(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(SlideRightRoute(
            page:
                StudentListPage(bloc: BlocProvider.of<StudentBloc>(context)))),
        child: BlocBuilder<StudentBloc, StudentState>(
            buildWhen: (previous, current) =>
                current is StudentListLoaded || current is StudentLoading,
            builder: (_, state) => _itemCard(
                state is StudentLoading, AppText.students, Colors.redAccent,
                count: state is StudentListLoaded ? state.data.length : 0)));
  }

  // Grades
  Widget _grades(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            Navigator.of(context).push(SlideRightRoute(page: GradeListPage())),
        child: _itemCard(false, AppText.grades, Colors.green));
  }
}
