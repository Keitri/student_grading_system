part of 'grade_bloc.dart';

abstract class GradeEvent extends Equatable {
  const GradeEvent();

  @override
  List<Object> get props => [];
}

class GetAllGradesEvent extends GradeEvent {}

class GetGradeForSubjectEvent extends GradeEvent {
  final String subjectId;
  const GetGradeForSubjectEvent({required this.subjectId});
}

class GetGradeForStudentEvent extends GradeEvent {
  final String studentId;
  const GetGradeForStudentEvent({required this.studentId});
}

class GetGradeDetails extends GradeEvent {}

class LoadGradeList extends GradeEvent {}

class SaveNewGrade extends GradeEvent {
  final GradeModel newGrade;

  const SaveNewGrade({required this.newGrade});
}

class UpdateGradeDetails extends GradeEvent {
  final GradeModel updatedData;

  const UpdateGradeDetails({required this.updatedData});
}
