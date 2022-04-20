part of 'grade_bloc.dart';

abstract class GradeState extends Equatable {
  const GradeState();
  
  @override
  List<Object> get props => [];
}

class GradeInitial extends GradeState {}
