import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../interface/idatabase.dart';
import '../../model/grade.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final IDatabase db;
  final List<GradeModel> _grades = <GradeModel>[];

  List<GradeModel> get grades => _grades;

  GradeBloc({required this.db}) : super(GradeInitial()) {
    on<GetGradeForSubjectEvent>((event, emit) {
      emit(GradeLoading());
      db.getSubjectGradeStream(event.subjectId).listen((event) {
        // Load Grades
        _grades.clear();
        _grades.addAll(event);
        add(LoadGradeList());
      });
    });
    on<GetGradeForStudentEvent>((event, emit) {
      emit(GradeLoading());
      db.getStudentGradeStream(event.studentId).listen((event) {
        // Load Grades
        _grades.clear();
        _grades.addAll(event);
        add(LoadGradeList());
      });
    });
    on<LoadGradeList>((event, emit) {
      emit(GradeLoading());
      emit(GradeListLoaded(data: _grades));
    });
    on<SaveNewGrade>((event, emit) async {
      emit(NewGradeSaving());
      final result = await db.saveGrade(event.newGrade);
      if (result.isError) {
        emit(NewGradeError(errorMessage: result.message));
      } else {
        emit(NewGradeSaved());
        add(LoadGradeList());
      }
    });
    on<GetAllGradesEvent>((event, emit) {
      emit(GradeLoading());
      db.allGradeStream().listen((event) {
        // Load Grades
        _grades.clear();
        _grades.addAll(event);
        add(LoadGradeList());
      });
    });
  }
}
