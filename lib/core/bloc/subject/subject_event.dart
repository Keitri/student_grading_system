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
