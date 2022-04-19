part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetAllStudentEvent extends StudentEvent {}

class GetStudentDetails extends StudentEvent {}

class LoadStudentList extends StudentEvent {}

class SaveNewStudentUser extends StudentEvent {
  final StudentModel newUser;

  const SaveNewStudentUser({required this.newUser});
}
