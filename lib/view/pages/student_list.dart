import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/view/pages/student_form.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/bloc/student/student_bloc.dart';
import '../../core/model/student.dart';
import '../transitions/slide_right_route.dart';

class StudentListPage extends StatelessWidget {
  final StudentBloc bloc;
  final colorAccent = Colors.redAccent;

  StudentListPage({required this.bloc, Key? key}) : super(key: key) {
    if (bloc.state.runtimeType != StudentInitial) {
      bloc.add(LoadStudentList());
    }
  }

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
                    .push(SlideRightRoute(page: StudentForm(bloc: bloc)));
              },
              child: const Center(child: Icon(Icons.add)),
            )));
  }

  // No Student Text
  Widget _noStudent() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(AppText.noStudent,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Container(height: 10),
              const Text(AppText.addStudent,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  // StudentList List
  Widget _studentList(List<StudentModel> data) {
    return ListView(children: [
      ...data.map((f) => Column(children: [
            ListTile(
              title: Text(f.firstName + ' ' + f.lastName),
              subtitle: Text(f.mobileNumber),
            ),
            const Divider()
          ]))
    ]);
  }

  Widget _mainContent(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is StudentListLoaded || current is StudentLoading,
      builder: (context, state) {
        if (state is StudentListLoaded) {
          return state.data.isEmpty ? _noStudent() : _studentList(state.data);
        }
        return Center(child: CircularProgressIndicator(color: colorAccent));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppText.students),
          centerTitle: true,
          backgroundColor: colorAccent,
        ),
        body: Stack(children: [_mainContent(context), _addButton(context)]));
  }
}
