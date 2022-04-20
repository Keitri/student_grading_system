import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/grade.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  GradeBloc() : super(GradeInitial()) {
    on<GradeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
