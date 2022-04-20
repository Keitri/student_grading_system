import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:student_grading_app/core/bloc/class/class_bloc.dart';
import 'package:student_grading_app/core/bloc/grade/grade_bloc.dart';
import 'package:student_grading_app/core/bloc/subject/subject_bloc.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';
import 'package:student_grading_app/view/pages/faculty_subject.dart';
import 'package:student_grading_app/view/transitions/transitions.dart';

import '../../core/bloc/student/student_bloc.dart';
import '../../core/model/subject.dart';
import '../values/apptext.dart';

class FacultyHome extends StatelessWidget {
  IDatabase get _db => Injector.appInstance.get<IDatabase>();

  const FacultyHome({Key? key}) : super(key: key);

  // No Subject Text
  Widget _noSubject() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(AppText.noSubject,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Container(height: 10),
              const Text(AppText.requestSubject,
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]));
  }

  Widget _subjectList(BuildContext context, List<SubjectModel> subjects) {
    // SubjectList List
    return ListView(children: [
      ...subjects.map((f) => Column(children: [
            ListTile(
              title: Text(f.code),
              subtitle: Text(f.description),
              trailing: Text(
                f.studentIds.length.toString() +
                    " " +
                    AppText.students.toLowerCase(),
                style: const TextStyle(color: Colors.black54),
              ),
              onTap: () {
                // Show Faculty Subject Details
                final subjectBloc = BlocProvider.of<SubjectBloc>(context);
                subjectBloc.add(UpdateSubjectDetailsView(updatedData: f));
                Navigator.of(context).push(SlideRightRoute(
                    page: MultiBlocProvider(
                  providers: [
                    BlocProvider<ClassBloc>(
                        lazy: false,
                        create: (_) => ClassBloc(db: _db)
                          ..add(GetClassForSubjectEvent(subjectId: f.id))),
                    BlocProvider<GradeBloc>(
                        lazy: false,
                        create: (_) => GradeBloc(db: _db)
                          ..add(GetGradeForSubjectEvent(subjectId: f.id)))
                  ],
                  child: FacultySubjectDetails(
                      bloc: subjectBloc,
                      studentBloc: BlocProvider.of<StudentBloc>(context),
                      data: f),
                )));
              },
            ),
            const Divider()
          ]))
    ]);
  }

  Widget _mainContent(BuildContext context, SubjectState state) {
    if (state is SubjectListLoaded) {
      return state.data.isEmpty
          ? _noSubject()
          : _subjectList(context, state.data);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
        buildWhen: (previous, current) =>
            current is SubjectLoading || current is SubjectListLoaded,
        builder: (_, state) {
          return Stack(children: [_mainContent(context, state)]);
        });
  }
}
