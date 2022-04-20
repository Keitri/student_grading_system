import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/class/class_bloc.dart';
import 'package:student_grading_app/view/pages/class_details.dart';
import 'package:student_grading_app/view/transitions/transitions.dart';
import 'package:uuid/uuid.dart';

import '../../core/bloc/student/student_bloc.dart';
import '../../core/bloc/subject/subject_bloc.dart';
import '../../core/model/class.dart';
import '../../core/model/student.dart';
import '../../core/model/subject.dart';
import '../values/apptext.dart';

class FacultySubjectDetails extends StatelessWidget {
  final SubjectBloc bloc;
  final StudentBloc studentBloc;
  final SubjectModel data;
  final List<StudentModel> studentList = <StudentModel>[];
  final Color accentColor = Colors.orangeAccent;

  FacultySubjectDetails(
      {required this.bloc,
      required this.studentBloc,
      required this.data,
      Key? key})
      : super(key: key) {
    // Get Student Model List
    for (StudentModel student in studentBloc.students) {
      try {
        data.studentIds.firstWhere((studentId) => studentId == student.id);
        studentList.add(student);
      } catch (e) {
        // Do Nothing
      }
    }
  }

  Widget _subjectDetails(BuildContext context, SubjectModel subject) {
    return Column(children: [
      ListTile(
        title: Text(subject.description),
        subtitle: const Text(AppText.description),
        trailing: Text(subject.units.toString() + " Units"),
      ),
      const Divider()
    ]);
  }

  Widget _notGraded() {
    return const Text(
      'Not Graded',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget _studentList(List<StudentModel> students) {
    return ListView(children: [
      ...students.map((s) => Column(children: [
            ListTile(
                onTap: () {
                  // Show Grade Screen
                },
                title: Text(s.firstName + " " + s.lastName),
                trailing: _notGraded()),
            const Divider()
          ]))
    ]);
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
              const Text(AppText.requestStudent,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  Widget _noClass() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(AppText.noClass,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Container(height: 10),
              const Text(AppText.addClass,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  // Add Class Button
  Widget _addClassButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            margin: const EdgeInsets.all(20),
            child: FloatingActionButton(
              backgroundColor: accentColor,
              onPressed: () {
                // Check if there are students assigned
                if (studentList.isEmpty) {
                  // Show No Student Message
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(AppText.noStudent),
                      backgroundColor: Colors.red));
                  return;
                }
                final classBloc = BlocProvider.of<ClassBloc>(context);
                bool classInProgress = false;
                try {
                  classBloc.classes.firstWhere((c) => c.endTime == null);
                  classInProgress = true;
                } catch (e) {
                  classInProgress = false;
                }
                // Don't add if there's an existing Class in Progress
                if (!classInProgress) {
                  // Start a Class
                  classBloc.add(SaveNewClass(
                      newClass: ClassModel(
                          id: const Uuid().v4(),
                          subjectId: data.id,
                          facultyId: data.facultyId,
                          startTime: DateTime.now(),
                          studentIds: const [])));
                } else {
                  // Show Error Message
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(AppText.classInProgress),
                      backgroundColor: Colors.red));
                }
              },
              child: const Center(child: Icon(Icons.add)),
            )));
  }

  Widget _inProgress() {
    return const Text(
      'In Progress...',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget _classDuration(ClassModel classData) {
    // Compute Duration
    final duration = classData.endTime!.millisecondsSinceEpoch -
        classData.startTime.millisecondsSinceEpoch;
    // Show in Minutes
    final timeInMinutes = duration / 1000 / 60;
    return Text(timeInMinutes.toStringAsFixed(2) + " min");
  }

  Widget _classList(BuildContext context, List<ClassModel> classes) {
    return ListView(children: [
      ...classes.map((c) => Column(children: [
            ListTile(
                onTap: () {
                  final classBloc = BlocProvider.of<ClassBloc>(context);
                  classBloc.add(UpdateClassDetails(updatedData: c));
                  // Show Class Details Screen
                  Navigator.of(context).push(SlideRightRoute(
                      page: ClassDetailsPage(
                    bloc: classBloc,
                    subject: data,
                    studentList: studentList,
                  )));
                },
                title: Text(c.startTime.toIso8601String()),
                subtitle: Text(c.studentIds.length.toString() + " students"),
                trailing:
                    c.endTime == null ? _inProgress() : _classDuration(c)),
            const Divider()
          ]))
    ]);
  }

  Widget _classSection(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
        buildWhen: (previous, current) => current is ClassListLoaded,
        builder: (context, state) {
          final loadedState = state as ClassListLoaded;
          return Stack(children: [
            loadedState.data.isEmpty
                ? _noClass()
                : _classList(context, loadedState.data),
            _addClassButton(context)
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                title: Text(data.code),
                centerTitle: true,
                backgroundColor: accentColor),
            body: Column(children: [
              _subjectDetails(context, data),
              TabBar(tabs: [
                Tab(
                    child: Text(
                  AppText.students +
                      " (" +
                      data.studentIds.length.toString() +
                      ")",
                  style: const TextStyle(color: Colors.black),
                )),
                const Tab(
                    child: Text(
                  AppText.categories,
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: BlocBuilder<ClassBloc, ClassState>(
                        buildWhen: (previous, current) =>
                            current is ClassListLoaded,
                        builder: (context, state) {
                          return Text(
                              AppText.classes +
                                  " (" +
                                  (state is ClassListLoaded
                                      ? state.data.length.toString()
                                      : "0") +
                                  ")",
                              style: const TextStyle(color: Colors.black));
                        }))
              ]),
              // Tab Bar for Students and Class
              Expanded(
                  child: TabBarView(children: [
                studentList.isEmpty ? _noStudent() : _studentList(studentList),
                Container(color: Colors.green),
                _classSection(context)
              ]))
            ]
                // Expanded(child: _studentList(studentList)),
                )));
  }
}
