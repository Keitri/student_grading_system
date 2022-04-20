import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../interface/idatabase.dart';
import '../../model/subject.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final IDatabase db;
  final List<SubjectModel> _subjects = <SubjectModel>[];

  List<SubjectModel> get subjects => _subjects;

  SubjectBloc({required this.db}) : super(SubjectInitial()) {
    on<SaveNewSubjectUser>((event, emit) async {
      emit(NewSubjectSaving());
      final result = await db.saveSubject(event.newSubject);
      if (result.isError) {
        emit(NewSubjectError(errorMessage: result.message));
      } else {
        emit(NewSubjectSaved());
      }
    });
    on<LoadSubjectList>((event, emit) {
      emit(SubjectListLoaded(data: _subjects));
    });
    on<GetAllSubjectEvent>((event, emit) {
      emit(SubjectLoading());
      db.allSubjectStream().listen((event) {
        // Load Students
        _subjects.clear();
        _subjects.addAll(event);
        add(LoadSubjectList());
      });
    });
    on<UpdateSubjectDetails>((event, emit) {
      emit(SubjectDetailsUpdated(updatedData: event.updatedData));
      // Update Database
      db.saveSubject(event.updatedData);
    });
    on<GetSubjectForFacultyEvent>((event, emit) {
      emit(SubjectLoading());
      db.getFacultySubjectStream(event.facultyId).listen((event) {
        // Load Students
        _subjects.clear();
        _subjects.addAll(event);
        add(LoadSubjectList());
      });
    });
  }
}
