import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/view/pages/faculty_form.dart';
import 'package:student_grading_app/view/transitions/transitions.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/bloc/faculty/faculty_bloc.dart';
import '../../core/model/faculty.dart';

class FacultyListPage extends StatelessWidget {
  final FacultyBloc bloc;
  final colorAccent = Colors.redAccent;

  FacultyListPage({required this.bloc, Key? key}) : super(key: key) {
    if (bloc.state.runtimeType != FacultyInitial) {
      bloc.add(LoadFacultyList());
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
                    .push(SlideRightRoute(page: FacultyForm(bloc: bloc)));
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

  // Faculty List
  Widget _facultyList(List<FacultyModel> data) {
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
    return BlocBuilder<FacultyBloc, FacultyState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is FacultyListLoaded || current is FacultyLoading,
      builder: (context, state) {
        if (state is FacultyListLoaded) {
          return state.data.isEmpty ? _noFaculty() : _facultyList(state.data);
        }
        return Center(child: CircularProgressIndicator(color: colorAccent));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppText.faculties),
            centerTitle: true,
            backgroundColor: colorAccent),
        body: Stack(children: [_mainContent(context), _addButton(context)]));
  }
}
