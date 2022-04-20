import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/view/dialogs/grade_breakdown_dialog.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/widget.dart';

import '../../core/bloc/grade/grade_bloc.dart';
import '../../core/model/grade.dart';

class GradeListPage extends StatelessWidget {
  final colorAccent = Colors.green;
  final GradeBloc bloc;

  const GradeListPage({required this.bloc, Key? key}) : super(key: key);

  // Add Button
  // Widget _addButton(BuildContext context) {
  //   // Show Add for Faculty User Only
  //   bool isFaculty = false;
  //   final authState = BlocProvider.of<AuthBloc>(context).state;
  //   if (authState is Authenticated) {
  //     isFaculty = authState.currentUser is FacultyModel;
  //   }
  //   return isFaculty
  //       ? Align(
  //           alignment: Alignment.bottomRight,
  //           child: Container(
  //               margin: const EdgeInsets.all(20),
  //               child: FloatingActionButton(
  //                 backgroundColor: colorAccent,
  //                 onPressed: () {},
  //                 child: const Center(child: Icon(Icons.add)),
  //               )))
  //       : Container();
  // }

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

  // Grade List
  Widget _gradeList(BuildContext context, List<GradeModel> data) {
    return ListView(children: [
      ...data.map((g) => Column(children: [
            ListTile(
              title: Text(g.studentName),
              subtitle: Text(g.subjectName),
              trailing: totalGradeWidget(g.totalGrade),
              onTap: () {
                // Show Gread Breakdown
                showDialog(
                    context: context,
                    builder: (_) => GradeBreakdownDialog(grade: g));
              },
            ),
            const Divider()
          ]))
    ]);
  }

  Widget _mainContent(BuildContext context) {
    return BlocBuilder<GradeBloc, GradeState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is GradeListLoaded || current is GradeLoading,
      builder: (context, state) {
        if (state is GradeListLoaded) {
          return state.data.isEmpty
              ? _noGrade()
              : _gradeList(context, state.data);
        }
        return Center(child: CircularProgressIndicator(color: colorAccent));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppText.grades),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Stack(children: [_mainContent(context)]));
  }
}
