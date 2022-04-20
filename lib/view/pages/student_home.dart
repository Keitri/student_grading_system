import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/grade/grade_bloc.dart';
import 'package:student_grading_app/core/model/base_user.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:student_grading_app/core/model/grade.dart';

import '../../core/bloc/subject/subject_bloc.dart';
import '../widgets/widget.dart';

class StudentHome extends StatelessWidget {
  final BaseUser userData;
  const StudentHome({required this.userData, Key? key}) : super(key: key);

  // QR Id
  Widget _qrID() {
    return Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Center(
            child: QrImage(
                data: userData.id, version: QrVersions.auto, size: 220)));
  }

  Widget _studentDetails() {
    return Column(children: [
      Text(
        userData.firstName + " " + userData.lastName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      space,
      Text(userData.mobileNumber),
      space
    ]);
  }

  Widget _notGraded() {
    return const Text(
      'Not Graded',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget _gradeIcon(List<GradeModel> grades, String subjectId) {
    try {
      final grade = grades.firstWhere((g) => g.subjectId == subjectId);
      return totalGradeWidget(grade.totalGrade);
    } catch (e) {
      // No Grade
      return _notGraded();
    }
  }

  // List of Subjects
  Widget _subjectList() {
    return BlocBuilder<SubjectBloc, SubjectState>(builder: (context, state) {
      if (state is SubjectListLoaded) {
        return BlocBuilder<GradeBloc, GradeState>(
            builder: (context, gradeState) {
          final grades = <GradeModel>[];
          if (gradeState is GradeListLoaded) {
            grades.clear();
            grades.addAll(gradeState.data);
          }

          return Expanded(
              child: ListView(
            children: [
              ...state.data.map((s) => Column(children: [
                    ListTile(
                      leading: _gradeIcon(grades, s.id),
                      trailing: Text('${s.units} units'),
                      title: Text(s.code),
                      subtitle: Text(s.description),
                    ),
                    const Divider()
                  ]))
            ],
          ));
        });
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_qrID(), _studentDetails(), _subjectList()]);
  }
}
