import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'faculty_event.dart';
part 'faculty_state.dart';

class FacultyBloc extends Bloc<FacultyEvent, FacultyState> {
  FacultyBloc() : super(FacultyInitial()) {
    on<FacultyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
