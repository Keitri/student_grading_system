import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/bloc/student/student_bloc.dart';
import 'package:student_grading_app/core/bloc/subject/subject_bloc.dart';
import 'package:student_grading_app/view/dialogs/select_students.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/bloc/faculty/faculty_bloc.dart';
import '../../core/model/faculty.dart';
import '../../core/model/student.dart';
import '../../core/model/subject.dart';
import '../dialogs/select_faculty.dart';

class SubjectDetailsPage extends StatelessWidget {
  final SubjectBloc bloc;
  final StudentBloc studentBloc;
  final FacultyBloc facultyBloc;
  final SubjectModel data;
  const SubjectDetailsPage(
      {required this.bloc,
      required this.studentBloc,
      required this.facultyBloc,
      required this.data,
      Key? key})
      : super(key: key);

  String _getFacultyName(String facultyId) {
    final FacultyModel result = facultyBloc.faculties.firstWhere(
        (f) => f.id == facultyId,
        orElse: () => const FacultyModel.blank());

    if (result.id == facultyId) {
      return result.firstName + " " + result.lastName;
    } else {
      return facultyId;
    }
  }

  Widget _subjectDetails(BuildContext context, SubjectModel subject) {
    return Column(children: [
      ListTile(
        title: Text(subject.description),
        subtitle: const Text(AppText.description),
        trailing: Text(subject.units.toString() + " Units"),
      ),
      const Divider(),
      ListTile(
        title: Text(_getFacultyName(subject.facultyId)),
        subtitle: const Text(AppText.facultyAssigned),
        trailing: TextButton(
          child: const Text(AppText.change),
          onPressed: () async {
            // Show Faculty Selection Dialog
            final selectedFaculty = await showDialog(
                context: context,
                builder: (context) {
                  return SelectFacultyDialog(
                      values: facultyBloc.faculties,
                      selectedFacultyId: subject.facultyId);
                });

            if (selectedFaculty is FacultyModel) {
              // Set New Value
              bloc.add(UpdateSubjectDetails(
                  updatedData: SubjectModel(
                      id: subject.id,
                      code: subject.code,
                      description: subject.description,
                      units: subject.units,
                      facultyId: selectedFaculty.id,
                      categories: subject.categories,
                      studentIds: subject.studentIds)));
            }
          },
        ),
      )
    ]);
  }

  Widget _studentList(List<StudentModel> students) {
    return ListView(children: [
      ...students.map((s) => ListTile(
            title: Text(s.firstName + " " + s.lastName),
          ))
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
              const Text(AppText.addStudent,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(data.code),
            centerTitle: true,
            backgroundColor: Colors.orangeAccent),
        body: BlocBuilder<SubjectBloc, SubjectState>(
            bloc: bloc,
            buildWhen: (previous, current) => current is SubjectDetailsUpdated,
            builder: (context, state) {
              if (state is SubjectDetailsUpdated) {
                // Get Student Model List
                final studentList = <StudentModel>[];
                for (StudentModel student in studentBloc.students) {
                  try {
                    state.updatedData.studentIds
                        .firstWhere((studentId) => studentId == student.id);
                    studentList.add(student);
                  } catch (e) {
                    // Do Nothing
                  }
                }
                return Column(children: [
                  _subjectDetails(context, state.updatedData),
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text(
                            AppText.students +
                                " (" +
                                state.updatedData.studentIds.length.toString() +
                                ")",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                              child: Divider(
                            thickness: 1,
                          )),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              // Show Student List
                              final selectedStudents = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SelectStudentsDialog(
                                        values: studentBloc.students,
                                        selectedValues: studentList);
                                  });

                              if (selectedStudents is List<StudentModel>) {
                                // Set New Value
                                bloc.add(UpdateSubjectDetails(
                                    updatedData: SubjectModel(
                                        id: state.updatedData.id,
                                        code: state.updatedData.code,
                                        description:
                                            state.updatedData.description,
                                        units: state.updatedData.units,
                                        facultyId: state.updatedData.facultyId,
                                        categories:
                                            state.updatedData.categories,
                                        studentIds: selectedStudents
                                            .map((e) => e.id)
                                            .toList())));
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      child: studentList.isEmpty
                          ? _noStudent()
                          : _studentList(studentList))
                ]);
              } else {
                return Container();
              }
            }));
  }
}
