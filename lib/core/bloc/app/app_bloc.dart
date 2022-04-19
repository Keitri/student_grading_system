import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_grading_app/core/interface/iauth.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final IAuth auth;
  final IDatabase database;

  AppBloc({required this.auth, required this.database}) : super(AppInitial()) {
    on<InitializeAppEvent>((event, emit) async {
      // Load env file
      await dotenv.load(fileName: ".env");
      // Create Default Registrar if doesn't exist
      final defaultRegistrar = await auth.ensureDefaultRegistrarCreated();
      // Save Created Registrat in Database
      if (defaultRegistrar != null) {
        await database.saveRegistrarUser(defaultRegistrar);
      }
      emit(AppLoaded());
    });
  }
}
