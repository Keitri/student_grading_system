import 'package:flutter/material.dart';
import 'package:student_grading_app/core/bloc/grade/grade_bloc.dart';
import 'package:student_grading_app/core/model/grade.dart';
import 'package:student_grading_app/core/model/student.dart';
import 'package:student_grading_app/core/model/subject.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/button.dart';
import 'package:uuid/uuid.dart';

import '../../core/model/class.dart';
import '../widgets/widget.dart';

class GradeDialog extends StatefulWidget {
  final GradeBloc bloc;
  final StudentModel student;
  final SubjectModel subject;
  final List<ClassModel> classes;

  const GradeDialog(
      {required this.bloc,
      required this.student,
      required this.subject,
      required this.classes,
      Key? key})
      : super(key: key);

  @override
  State<GradeDialog> createState() => _GradeDialogState();
}

class _GradeDialogState extends State<GradeDialog> {
  final Map<String, double> grades = {};
  final Map<String, TextEditingController> controllers = {};
  double totalGrade = 0;
  double attendanceGrade = 0;

  @override
  void initState() {
    super.initState();

    final totalClass = widget.classes.length;
    final studentAttendance =
        widget.classes.where((c) => c.studentIdExist(widget.student.id)).length;
    if (totalClass > 0) {
      grades["Attendance"] = studentAttendance / totalClass * 100;
    } else {
      grades["Attendance"] = 0;
    }

    // Create Text Controllers
    for (String category in widget.subject.categories) {
      grades[category] = 0;
      final _tcObject = TextEditingController();
      _tcObject.addListener(() {
        grades[category] = double.tryParse(_tcObject.text) ?? 0;
        _computeGrade();
      });
      controllers[category] = _tcObject;
    }
    _computeGrade();
  }

  // Subject Details
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

  void _computeGrade() {
    double total = 0;
    for (double g in grades.values) {
      total += g;
    }

    if (grades.isNotEmpty) {
      setState(() {
        totalGrade = total / grades.values.length;
      });
    }
  }

  // Student Details
  Widget _studentDetails(BuildContext context, StudentModel student) {
    return Column(children: [
      ListTile(
        title: Text(student.firstName + " " + student.lastName),
        subtitle: const Text(AppText.student),
        trailing: totalGradeWidget(totalGrade),
      ),
      const Divider()
    ]);
  }

  // Compute Attendance
  String _attendanceText() {
    final totalClass = widget.classes.length;
    final studentAttendance =
        widget.classes.where((c) => c.studentIdExist(widget.student.id)).length;
    if (totalClass > 0) {
      grades["Attendance"] = studentAttendance / totalClass * 100;
      _computeGrade();
    } else {
      grades["Attendance"] = 0;
    }
    return " ($studentAttendance/$totalClass)";
  }

  // Attendance Grade
  String _attendanceGrade() {
    if (grades["Attendance"] == null) {
      return "0";
    } else {
      return grades["Attendance"]!.toStringAsFixed(2);
    }
  }

  // Category List
  Widget _categoryList() {
    return ListView(children: [
      ListTile(
          title: Text(AppText.attendance + _attendanceText()),
          trailing: Text(_attendanceGrade())),
      ...widget.subject.categories.map((c) {
        return Column(children: [
          ListTile(
            title: Text(c),
            trailing: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 40,
                child: Center(
                    child: TextFormField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  controller: controllers[c],
                ))),
          ),
          const Divider()
        ]);
      })
    ]);
  }

  // Save Grade
  Widget _saveGradeButton() {
    return PrimaryButton(
        color: Colors.green,
        text: AppText.save,
        isLoading: false,
        onPressed: () {
          widget.bloc.add(SaveNewGrade(
              newGrade: GradeModel(
                  id: const Uuid().v4(),
                  totalGrade: totalGrade,
                  subjectId: widget.subject.id,
                  subjectName: widget.subject.code,
                  studentId: widget.student.id,
                  studentName:
                      widget.student.firstName + " " + widget.student.lastName,
                  parentsMobileNumber: widget.student.parentMobileNumber,
                  facultyId: widget.subject.facultyId,
                  createDate: DateTime.now(),
                  grades: grades)));
          // Close Dialog
          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.setGrade),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(children: [
        _subjectDetails(context, widget.subject),
        _studentDetails(context, widget.student),
        Expanded(child: _categoryList()),
        Container(margin: const EdgeInsets.all(10), child: _saveGradeButton())
      ]),
    );
  }
}
