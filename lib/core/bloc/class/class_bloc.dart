import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../interface/idatabase.dart';
import '../../model/class.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final IDatabase db;
  final List<ClassModel> _classes = <ClassModel>[];

  List<ClassModel> get classes => _classes;

  ClassBloc({required this.db}) : super(ClassInitial()) {
    on<SaveNewClass>((event, emit) async {
      emit(NewClassSaving());
      final result = await db.saveClass(event.newClass);
      if (result.isError) {
        emit(NewClassError(errorMessage: result.message));
      } else {
        emit(NewClassSaved());
      }
    });
    on<LoadClassList>((event, emit) {
      emit(ClassListLoaded(data: _classes));
    });
    on<UpdateClassDetails>((event, emit) {
      emit(ClassLoading());
      emit(ClassDetailsUpdated(updatedData: event.updatedData));
      // Update Database
      db.saveClass(event.updatedData);
    });
    on<GetClassForSubjectEvent>((event, emit) {
      emit(ClassLoading());
      db.getSubjectClassStream(event.subjectId).listen((event) {
        // Load Students
        _classes.clear();
        _classes.addAll(event);
        add(LoadClassList());
      });
    });
  }
}
