part of 'class_bloc.dart';

abstract class ClassState extends Equatable {
  const ClassState();

  @override
  List<Object> get props => [];
}

class ClassInitial extends ClassState {}

class ClassShowDetails extends ClassState {}

class ClassDetailsUpdated extends ClassState {
  final ClassModel updatedData;

  const ClassDetailsUpdated({required this.updatedData});

  @override
  List<Object> get props => [updatedData];
}

class ClassListLoaded extends ClassState {
  final List<ClassModel> data;

  const ClassListLoaded({required this.data});
}

class ClassLoading extends ClassState {}

class NewClassSaved extends ClassState {}

class NewClassSaving extends ClassState {}

class NewClassError extends ClassState {
  final String errorMessage;

  const NewClassError({required this.errorMessage});
}
