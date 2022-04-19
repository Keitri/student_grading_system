import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/model/student.dart';

class SelectStudentsDialog extends StatefulWidget {
  final List<StudentModel> selectedValues;
  final List<StudentModel> values;
  const SelectStudentsDialog(
      {required this.values, required this.selectedValues, Key? key})
      : super(key: key);

  @override
  State<SelectStudentsDialog> createState() => _SelectStudentsDialogState();
}

class _SelectStudentsDialogState extends State<SelectStudentsDialog> {
  bool _inSelectedList(String studentId) {
    try {
      widget.selectedValues.firstWhere((s) => s.id == studentId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _studentList(BuildContext context) {
    return ListView(children: [
      ...widget.values.map((s) => Column(
            children: [
              ListTile(
                title: Text(s.firstName + " " + s.lastName),
                trailing: Checkbox(
                    value: _inSelectedList(s.id),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          // Add to Selected Values
                          widget.selectedValues.add(s);
                        } else {
                          // Remove from Selected Values
                          widget.selectedValues.remove(s);
                        }
                      });
                    }),
                onTap: () {
                  Navigator.of(context).pop(widget.selectedValues);
                },
              ),
              const Divider()
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(widget.selectedValues);
          return false;
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: Dialog(
                child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text(AppText.students),
                centerTitle: true,
              ),
              body: _studentList(context),
            ))));
  }
}
