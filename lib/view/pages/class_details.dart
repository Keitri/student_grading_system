import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/core/model/student.dart';
import 'package:student_grading_app/view/dialogs/scan_id_dialog.dart';

import '../../core/bloc/class/class_bloc.dart';
import '../../core/model/class.dart';
import '../../core/model/subject.dart';
import '../values/apptext.dart';
import '../widgets/button.dart';

class ClassDetailsPage extends StatelessWidget {
  final ClassBloc bloc;
  final SubjectModel subject;
  final List<StudentModel> studentList;
  final Color accentColor = Colors.orangeAccent;

  const ClassDetailsPage(
      {required this.bloc,
      required this.subject,
      required this.studentList,
      Key? key})
      : super(key: key);

  Widget _subjectDetails(
      BuildContext context, SubjectModel subject, ClassModel classData) {
    return Column(children: [
      ListTile(
        title: Text(subject.description),
        subtitle: const Text(AppText.description),
        trailing: Text(subject.units.toString() + " Units"),
      ),
      const Divider(),
      ListTile(
        title: Text(classData.startTime.toIso8601String()),
        subtitle: const Text(AppText.startTime),
      ),
      const Divider()
    ]);
  }

  Widget _studentIsPresent(String studentId, ClassModel classData) {
    try {
      classData.studentIds.firstWhere((id) => id == studentId);
      return const Icon(Icons.check, color: Colors.green);
    } catch (e) {
      return const Icon(Icons.close, color: Colors.red);
    }
  }

  Widget _scanStudentButton(BuildContext context, ClassModel classData) {
    return PrimaryButton(
        text: AppText.scanId,
        isLoading: false,
        color: Colors.green,
        onPressed: () async {
          // Show QR Scanner
          final studentId = await showDialog(
              context: context, builder: (_) => const ScanIdDialog());
          if (studentId != null) {
            // Validate Id from QR Code
            try {
              studentList.firstWhere((s) => s.id == studentId);
            } catch (e) {
              // Show QR Invalid
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppText.invalidId),
                  backgroundColor: Colors.red));
              return;
            }

            // Check if Student already Scanned
            try {
              classData.studentIds.firstWhere((s) => s == studentId);
              // Show Already Scanned
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppText.studentAlreadyRecorded),
                  backgroundColor: Colors.red));
              return;
            } catch (e) {
              // Do Nothing
            }

            // Save Student Id
            classData.studentIds.add(studentId);
            bloc.add(UpdateClassDetails(updatedData: classData));
            // Show Scanned Message
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(AppText.studentScannedSuccess),
                backgroundColor: Colors.green));
          }
        });
  }

  Widget _endClassButton(BuildContext context, ClassModel classData) {
    return PrimaryButton(
        text: AppText.endClass,
        isLoading: false,
        color: Colors.red,
        onPressed: () {
          // End Class
          bloc.add(UpdateClassDetails(
              updatedData: ClassModel(
                  id: classData.id,
                  facultyId: classData.facultyId,
                  subjectId: classData.subjectId,
                  startTime: classData.startTime,
                  studentIds: classData.studentIds,
                  endTime: DateTime.now())));
          // Go Back Screen
          Navigator.of(context).pop();
        });
  }

  Widget _bottomButtons(BuildContext context, ClassModel classData) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          // Scan Student Id
          Expanded(child: _scanStudentButton(context, classData)),
          const SizedBox(width: 10),
          // End Class
          SizedBox(width: 150, child: _endClassButton(context, classData))
        ]));
  }

  Widget _studentList(ClassModel classData, List<StudentModel> students) {
    return ListView(children: [
      ...students.map((s) => Column(children: [
            ListTile(
                title: Text(s.firstName + " " + s.lastName),
                trailing: _studentIsPresent(s.id, classData)),
            const Divider(),
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(subject.code),
            centerTitle: true,
            backgroundColor: accentColor),
        body: BlocBuilder<ClassBloc, ClassState>(
          bloc: bloc,
          buildWhen: (previous, current) => current is ClassDetailsUpdated,
          builder: (context, state) {
            if (state is ClassDetailsUpdated) {
              return Column(children: [
                _subjectDetails(context, subject, state.updatedData),
                Container(
                    margin: const EdgeInsets.all(15),
                    child: Row(children: [
                      Text(
                        AppText.students +
                            " (" +
                            studentList.length.toString() +
                            ")",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                          child: Divider(
                        thickness: 1,
                      )),
                      const SizedBox(width: 10)
                    ])),
                Expanded(child: _studentList(state.updatedData, studentList)),
                _bottomButtons(context, state.updatedData)
              ]);
            } else {
              return Container();
            }
          },
        ));
  }
}
