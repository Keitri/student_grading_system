import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:student_grading_app/core/bloc/auth/auth_bloc.dart';
import 'package:student_grading_app/core/interface/iauth.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';
import 'package:student_grading_app/services/firebase/firebase_auth.dart';
import 'package:student_grading_app/services/firebase/firestore.dart';
import 'package:student_grading_app/view/pages/grade_list.dart';
import 'package:student_grading_app/view/pages/home.dart';
import 'package:student_grading_app/view/pages/student_list.dart';
import 'package:student_grading_app/view/pages/subject_list.dart';
import 'package:student_grading_app/view/pages/routes.dart';
import 'package:student_grading_app/view/transitions/transitions.dart';
import 'core/bloc/app/app_bloc.dart';
import 'core/bloc/login/login_bloc.dart';
import 'view/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set Bloc Observer

  // Setup Dependencies
  Injector.appInstance.registerDependency<IAuth>(() => FBAuth());
  Injector.appInstance.registerDependency<IDatabase>(() => Firestore());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  MyApp({Key? key}) : super(key: key);

  NavigatorState? get _navigator => _navigatorKey.currentState;

  IAuth get _auth => Injector.appInstance.get<IAuth>();
  IDatabase get _db => Injector.appInstance.get<IDatabase>();

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return FadeRoute(page: const WelcomePage());
      case AppRoutes.login:
        return FadeRoute(
            page: BlocProvider<LoginBloc>(
                create: (_) => LoginBloc(auth: _auth, db: _db),
                child: LoginPage()));
      case AppRoutes.home:
        return FadeRoute(page: const HomePage());
      case AppRoutes.subjectList:
        return SlideRightRoute(page: const SubjectListPage());
      case AppRoutes.studentList:
        return SlideRightRoute(page: const StudentListPage());
      case AppRoutes.gradeList:
        return SlideRightRoute(page: const GradeListPage());
      default:
        return FadeRoute(page: Container());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
              create: (_) => AppBloc(auth: _auth, database: _db)
                ..add(InitializeAppEvent())),
          BlocProvider<AuthBloc>(create: (_) => AuthBloc(auth: _auth, db: _db))
        ],
        child: BlocListener<AuthBloc, AuthState>(
            listener: (_, state) {
              if (state is Authenticated) {
                // Go to Main Page
                _navigator?.pushReplacementNamed(AppRoutes.home);
              } else {
                // Go to Login Page
                _navigator?.pushReplacementNamed(AppRoutes.login);
              }
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: _navigatorKey,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: AppRoutes.welcome,
              onGenerateRoute: _generateRoute,
            )));
  }
}
