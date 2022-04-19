import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:student_grading_app/core/bloc/subject/subject_bloc.dart';
import 'package:student_grading_app/core/model/registrar.dart';
import 'package:student_grading_app/core/model/role.dart';
import 'package:student_grading_app/view/dialogs/change_password.dart';
import 'package:student_grading_app/view/pages/registrar_home.dart';
import 'package:student_grading_app/view/values/apptext.dart';
import 'package:student_grading_app/view/widgets/button.dart';

import '../../core/bloc/auth/auth_bloc.dart';
import '../../core/bloc/faculty/faculty_bloc.dart';
import '../../core/bloc/student/student_bloc.dart';
import '../../core/interface/idatabase.dart';

class HomePage extends StatelessWidget {
  IDatabase get _db => Injector.appInstance.get<IDatabase>();

  const HomePage({Key? key}) : super(key: key);

  String _accountType(UserRole role) {
    switch (role) {
      case UserRole.registrar:
        return "Registrar";
      case UserRole.faculty:
        return "Faculty";
      case UserRole.student:
        return "Student";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (_, current) => current is Authenticated,
        builder: (_, state) {
          final currentUser = (state as Authenticated).currentUser;
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppText.appName),
              centerTitle: true,
            ),
            drawer: Container(
                color: Colors.white,
                width: 250,
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      height: 140,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                                currentUser.firstName +
                                    " " +
                                    currentUser.lastName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),

                            Text(_accountType(currentUser.role),
                                style: const TextStyle(color: Colors.white)),
                            // Mobile Number
                            Text(
                              currentUser.mobileNumber,
                              style: const TextStyle(color: Colors.white),
                            )
                          ])),
                  Expanded(child: Container()),
                  // Logout Button
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: PrimaryButton(
                          text: AppText.logout,
                          color: Colors.red,
                          isLoading: false,
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(LogoutEvent());
                          }))
                ])),
            body: _contents(context, state),
          );
        });
  }

  Widget _contents(BuildContext context, AuthState state) {
    if (state is Authenticated) {
      switch (state.currentUser.runtimeType) {
        case RegistrarModel:
          return MultiBlocProvider(providers: [
            BlocProvider<StudentBloc>(
                lazy: false,
                create: (_) => StudentBloc(db: _db)..add(GetAllStudentEvent())),
            BlocProvider<FacultyBloc>(
              lazy: false,
              create: (_) => FacultyBloc(db: _db)..add(GetAllFacultyEvent()),
            ),
            BlocProvider<SubjectBloc>(
              lazy: false,
              create: (_) => SubjectBloc(db: _db)..add(GetAllSubjectEvent()),
            )
          ], child: const RegistrarHome());
        default:
          return Container(color: Colors.red);
      }
    } else {
      // Invalid AuthState
      return Container();
    }
  }
}
