import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:student_grading_app/view/widgets/widget.dart';

import '../../core/interface/isms.dart';
import '../../core/model/grade.dart';
import '../values/apptext.dart';
import '../widgets/button.dart';

class GradeBreakdownDialog extends StatelessWidget {
  final GradeModel grade;

  ISms get _smsService => Injector.appInstance.get<ISms>();

  const GradeBreakdownDialog({required this.grade, Key? key}) : super(key: key);

  // Subject Details
  Widget _subjectDetails(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(grade.subjectName),
        subtitle: const Text(AppText.description),
        trailing: totalGradeWidget(grade.totalGrade),
      ),
      const Divider()
    ]);
  }

  // Student Details
  Widget _studentDetails(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text(grade.studentName),
          subtitle: const Text(AppText.student)),
      const Divider(),
      ListTile(
          title: Text(grade.parentsMobileNumber),
          subtitle: const Text(AppText.parentMobileNumber)),
      const Divider(),
    ]);
  }

  // Category List
  Widget _categoryList() {
    return ListView(children: [
      ...grade.grades.keys.map((c) {
        return Column(children: [
          ListTile(title: Text(c), trailing: Text('${grade.grades[c]}')),
          const Divider()
        ]);
      })
    ]);
  }

  // Send SMS
  Widget _sendSMSButton(BuildContext context) {
    return PrimaryButton(
        color: Colors.green,
        text: AppText.sendGradeToParent,
        isLoading: false,
        onPressed: () async {
          final result = await _smsService.sendGrade(grade);
          if (result.isSuccess) {
            // Show Message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(result.message),
              backgroundColor: Colors.green,
            ));
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(result.message),
              backgroundColor: Colors.red,
            ));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.breakdown),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(children: [
        _subjectDetails(context),
        _studentDetails(context),
        Expanded(child: _categoryList()),
        Container(
            margin: const EdgeInsets.all(10), child: _sendSMSButton(context))
      ]),
    );
  }
}
