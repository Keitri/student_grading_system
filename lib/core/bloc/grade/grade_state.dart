part of 'grade_bloc.dart';

abstract class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object> get props => [];
}

class GradeInitial extends GradeState {}

class GradeDetailsUpdated extends GradeState {
  final GradeModel updatedData;

  const GradeDetailsUpdated({required this.updatedData});

  @override
  List<Object> get props => [updatedData];
}

class GradeListLoaded extends GradeState {
  final List<GradeModel> data;

  const GradeListLoaded({required this.data});
}

class GradeLoading extends GradeState {}

class NewGradeSaved extends GradeState {}

class NewGradeSaving extends GradeState {}

class NewGradeError extends GradeState {
  final String errorMessage;

  const NewGradeError({required this.errorMessage});
}
