part of 'faculty_bloc.dart';

abstract class FacultyState extends Equatable {
  const FacultyState();

  @override
  List<Object> get props => [];
}

class FacultyInitial extends FacultyState {}

class FacultyShowForm extends FacultyState {}

class FacultyShowDetails extends FacultyState {}

class FacultyLoaded extends FacultyState {}

class FacultyLoading extends FacultyState {}
