import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/model/subject.dart';
import 'package:student_grading_app/view/pages/subject_details.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/bloc/faculty/faculty_bloc.dart';
import '../../core/bloc/student/student_bloc.dart';
import '../../core/bloc/subject/subject_bloc.dart';
import '../transitions/slide_right_route.dart';
import 'subject_form.dart';

class SubjectListPage extends StatelessWidget {
  final SubjectBloc bloc;
  final FacultyBloc facultyBloc;
  final StudentBloc studentBloc;
  final colorAccent = Colors.orangeAccent;

  SubjectListPage(
      {required this.bloc,
      required this.facultyBloc,
      required this.studentBloc,
      Key? key})
      : super(key: key) {
    if (bloc.state.runtimeType != SubjectInitial) {
      bloc.add(LoadSubjectList());
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
                Navigator.of(context).push(SlideRightRoute(
                    page: SubjectForm(bloc: bloc, facultyBloc: facultyBloc)));
              },
              child: const Center(child: Icon(Icons.add)),
            )));
  }

  // No Subject Text
  Widget _noSubject() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(AppText.noSubject,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Container(height: 10),
              const Text(AppText.addSubject,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  // SubjectList List
  Widget _subjectList(BuildContext context, List<SubjectModel> data) {
    return ListView(children: [
      ...data.map((f) => Column(children: [
            ListTile(
              title: Text(f.code),
              subtitle: Text(f.description),
              trailing: Text(
                f.studentIds.length.toString() +
                    " " +
                    AppText.students.toLowerCase(),
                style: const TextStyle(color: Colors.black54),
              ),
              onTap: () {
                bloc.add(UpdateSubjectDetails(updatedData: f));
                Navigator.of(context).push(SlideRightRoute(
                    page: SubjectDetailsPage(
                        bloc: bloc,
                        facultyBloc: facultyBloc,
                        studentBloc: studentBloc,
                        data: f)));
              },
            ),
            const Divider()
          ]))
    ]);
  }

  Widget _mainContent(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is SubjectListLoaded || current is SubjectLoading,
      builder: (context, state) {
        if (state is SubjectListLoaded) {
          return state.data.isEmpty
              ? _noSubject()
              : _subjectList(context, state.data);
        }
        return Center(child: CircularProgressIndicator(color: colorAccent));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppText.subjects),
            centerTitle: true,
            backgroundColor: Colors.orangeAccent),
        body: Stack(children: [_mainContent(context), _addButton(context)]));
  }
}
