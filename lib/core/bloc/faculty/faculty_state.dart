part of 'faculty_bloc.dart';

abstract class FacultyState extends Equatable {
  const FacultyState();

  @override
  List<Object> get props => [];
}

class FacultyInitial extends FacultyState {}

class FacultyShowDetails extends FacultyState {}

class FacultyListLoaded extends FacultyState {
  final List<FacultyModel> data;

  const FacultyListLoaded({required this.data});
}

class FacultyLoading extends FacultyState {}

class NewFacultySaved extends FacultyState {}

class NewFacultySaving extends FacultyState {}

class NewFacultyError extends FacultyState {
  final String errorMessage;

  const NewFacultyError({required this.errorMessage});
}
