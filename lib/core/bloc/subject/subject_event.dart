part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

class GetAllSubjectEvent extends SubjectEvent {}

class GetSubjectForFacultyEvent extends SubjectEvent {
  final String facultyId;
  const GetSubjectForFacultyEvent({required this.facultyId});
}

class GetSubjectForStudentEvent extends SubjectEvent {
  final String studentId;
  const GetSubjectForStudentEvent({required this.studentId});
}

class GetSubjectDetails extends SubjectEvent {}

class LoadSubjectList extends SubjectEvent {}

class SaveNewSubjectUser extends SubjectEvent {
  final SubjectModel newSubject;

  const SaveNewSubjectUser({required this.newSubject});
}

class UpdateSubjectDetails extends SubjectEvent {
  final SubjectModel updatedData;

  const UpdateSubjectDetails({required this.updatedData});
}

class UpdateSubjectDetailsView extends SubjectEvent {
  final SubjectModel updatedData;

  const UpdateSubjectDetailsView({required this.updatedData});
}
