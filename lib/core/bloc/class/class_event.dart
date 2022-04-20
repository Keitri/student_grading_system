part of 'class_bloc.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class GetClassForSubjectEvent extends ClassEvent {
  final String subjectId;
  const GetClassForSubjectEvent({required this.subjectId});
}

class GetClassDetails extends ClassEvent {}

class LoadClassList extends ClassEvent {}

class SaveNewClass extends ClassEvent {
  final ClassModel newClass;

  const SaveNewClass({required this.newClass});
}

class UpdateClassDetails extends ClassEvent {
  final ClassModel updatedData;

  const UpdateClassDetails({required this.updatedData});
}

class UpdateClassDetailsView extends ClassEvent {
  final ClassModel updatedData;

  const UpdateClassDetailsView({required this.updatedData});
}

class AddStudentId extends ClassEvent {
  final String studentId;

  const AddStudentId({required this.studentId});
}
