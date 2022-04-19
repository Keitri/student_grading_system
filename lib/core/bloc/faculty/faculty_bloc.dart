import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';

import '../../model/faculty.dart';

part 'faculty_event.dart';
part 'faculty_state.dart';

class FacultyBloc extends Bloc<FacultyEvent, FacultyState> {
  final IDatabase db;
  final List<FacultyModel> _faculties = <FacultyModel>[];

  List<FacultyModel> get faculties => _faculties;

  FacultyBloc({required this.db}) : super(FacultyInitial()) {
    on<SaveNewFacultyUser>((event, emit) async {
      emit(NewFacultySaving());
      final result = await db.saveNewFacultyUser(event.newUser);
      if (result.isError) {
        emit(NewFacultyError(errorMessage: result.message));
      } else {
        emit(NewFacultySaved());
      }
    });
    on<LoadFacultyList>((event, emit) {
      emit(FacultyListLoaded(data: _faculties));
    });
    on<GetAllFacultyEvent>((event, emit) {
      emit(FacultyLoading());
      db.allFacultyStream().listen((event) {
        // Load Faculties
        _faculties.clear();
        _faculties.addAll(event);
        add(LoadFacultyList());
      });
    });
    on<GetFacultyDetails>((event, emit) {});
  }
}
