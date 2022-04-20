part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();

  @override
  List<Object> get props => [];
}

class SubjectInitial extends SubjectState {}

class SubjectShowDetails extends SubjectState {}

class SubjectDetailsUpdated extends SubjectState {
  final SubjectModel updatedData;

  const SubjectDetailsUpdated({required this.updatedData});

  @override
  List<Object> get props => [updatedData];
}

class SubjectListLoaded extends SubjectState {
  final List<SubjectModel> data;

  const SubjectListLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class SubjectLoading extends SubjectState {}

class NewSubjectSaved extends SubjectState {}

class NewSubjectSaving extends SubjectState {}

class NewSubjectError extends SubjectState {
  final String errorMessage;

  const NewSubjectError({required this.errorMessage});
}
