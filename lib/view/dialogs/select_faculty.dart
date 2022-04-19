import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';

import '../../core/model/faculty.dart';

class SelectFacultyDialog extends StatelessWidget {
  final List<FacultyModel> values;
  final String? selectedFacultyId;

  const SelectFacultyDialog(
      {required this.values, this.selectedFacultyId, Key? key})
      : super(key: key);

  Widget _facultyList(BuildContext context) {
    return ListView(children: [
      ...values.map((f) => Column(
            children: [
              ListTile(
                title: Text(f.firstName + " " + f.lastName),
                trailing: f.id == selectedFacultyId
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  Navigator.of(context).pop(f);
                },
              ),
              const Divider()
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Dialog(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text(AppText.faculties),
            centerTitle: true,
          ),
          body: _facultyList(context),
        )));
  }
}
