part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();
  
  @override
  List<Object> get props => [];
}

class SubjectInitial extends SubjectState {}
