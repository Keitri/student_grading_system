import 'package:flutter/material.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/button.dart';
import 'package:student_grading_app/view/widgets/textinputform.dart';
import 'package:student_grading_app/view/widgets/widget.dart';

class NewCategoryDialog extends StatelessWidget {
  final _tcNewCategory = TextEditingController();

  NewCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppText.newCategory),
      content: SizedBox(
        height: 120,
        child: Column(children: [
          TextInput(label: AppText.newCategory, controller: _tcNewCategory),
          space,
          PrimaryButton(
              text: AppText.add,
              isLoading: false,
              onPressed: () {
                // Pass New Category
                Navigator.of(context).pop(_tcNewCategory.text);
              })
        ]),
      ),
    );
  }
}
