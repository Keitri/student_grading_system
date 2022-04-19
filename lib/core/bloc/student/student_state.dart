part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudetnShowDetails extends StudentState {}

class StudentListLoaded extends StudentState {
  final List<StudentModel> data;

  const StudentListLoaded({required this.data});
}

class StudentLoading extends StudentState {}

class NewStudentSaved extends StudentState {}

class NewStudentSaving extends StudentState {}

class NewStudentError extends StudentState {
  final String errorMessage;

  const NewStudentError({required this.errorMessage});
}
