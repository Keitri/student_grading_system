import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/view/dialogs/select_faculty.dart';
import 'package:student_grading_app/view/widgets/dropdown_controller.dart';
import 'package:uuid/uuid.dart';

import '../../core/bloc/faculty/faculty_bloc.dart';
import '../../core/bloc/subject/subject_bloc.dart';
import '../../core/model/faculty.dart';
import '../../core/model/subject.dart';
import '../validators/validator.dart';
import '../values/apptext.dart';
import '../widgets/button.dart';
import '../widgets/dropdown_field.dart';
import '../widgets/textinputform.dart';
import '../widgets/widget.dart';

class SubjectForm extends StatelessWidget {
  SubjectForm({required this.bloc, required this.facultyBloc, Key? key})
      : super(key: key);

  final _tcCode = TextEditingController();
  final _tcDescription = TextEditingController();
  final _tcUnits = TextEditingController();
  final _dcFaculty = DropdownController();
  final colorAccent = Colors.orangeAccent;
  final List<String> categories = <String>[];
  final List<String> students = <String>[];

  final _formKey = GlobalKey<FormState>();

  final SubjectBloc bloc;
  final FacultyBloc facultyBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppText.newSubject),
            centerTitle: true,
            backgroundColor: colorAccent),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  // Subject Code
                  TextInput(
                      validator: Validator.requiredValidator,
                      label: AppText.subjectCode,
                      controller: _tcCode),
                  space,
                  // Description
                  TextInput(
                      validator: Validator.requiredValidator,
                      label: AppText.description,
                      controller: _tcDescription),
                  space,
                  // Units
                  TextInput(
                      validator: Validator.requiredValidator,
                      label: AppText.units,
                      controller: _tcUnits,
                      inputType: TextInputType.number),
                  space,
                  // Faculty
                  DropdownInput(
                    validator: Validator.requiredValidator,
                    label: AppText.facultyAssigned,
                    controller: _dcFaculty,
                    onPressed: () async {
                      // Hide Keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      // Show Faculty Selection Dialog
                      final selectedFaculty = await showDialog(
                          context: context,
                          builder: (context) {
                            return SelectFacultyDialog(
                                values: facultyBloc.faculties,
                                selectedFacultyId: _dcFaculty.key);
                          });

                      if (selectedFaculty is FacultyModel) {
                        // Set New Value

                        _dcFaculty.setValue(MapEntry(
                            selectedFaculty.id,
                            selectedFaculty.firstName +
                                " " +
                                selectedFaculty.lastName));
                      }
                    },
                  ),
                  space,
                  BlocConsumer<SubjectBloc, SubjectState>(
                      bloc: bloc,
                      listener: (context, state) {
                        // Hide Scaffold Messenger
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        if (state is NewSubjectError) {
                          // Show Error Message
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.errorMessage),
                              backgroundColor: Colors.red));
                        }

                        if (state is NewSubjectSaved) {
                          // Show Success Message
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(AppText.subjectSaved),
                                  backgroundColor: Colors.green));
                        }
                      },
                      builder: (_, state) {
                        return PrimaryButton(
                            text: AppText.save,
                            isLoading: state is NewSubjectSaving,
                            color: colorAccent,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Hide Keyboard
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // Try Save New Faculty
                                bloc.add(SaveNewSubjectUser(
                                    newSubject: SubjectModel(
                                        id: const Uuid().v4(),
                                        code: _tcCode.text,
                                        description: _tcDescription.text,
                                        units:
                                            double.tryParse(_tcUnits.text) ?? 0,
                                        facultyId: _dcFaculty.key,
                                        categories: categories,
                                        studentIds: students)));
                              }
                            });
                      })
                ]))));
  }
}
