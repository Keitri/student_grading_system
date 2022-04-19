import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/model/student.dart';

import '../../interface/idatabase.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final IDatabase db;
  final List<StudentModel> _students = <StudentModel>[];

  List<StudentModel> get students => _students;

  StudentBloc({required this.db}) : super(StudentInitial()) {
    on<SaveNewStudentUser>((event, emit) async {
      emit(NewStudentSaving());
      final result = await db.saveNewStudentUser(event.newUser);
      if (result.isError) {
        emit(NewStudentError(errorMessage: result.message));
      } else {
        emit(NewStudentSaved());
      }
    });
    on<LoadStudentList>((event, emit) {
      emit(StudentListLoaded(data: _students));
    });
    on<GetAllStudentEvent>((event, emit) {
      emit(StudentLoading());
      db.allStudentStream().listen((event) {
        // Load Students
        _students.clear();
        _students.addAll(event);
        add(LoadStudentList());
      });
    });
  }
}
