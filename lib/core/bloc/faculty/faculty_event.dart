part of 'faculty_bloc.dart';

abstract class FacultyEvent extends Equatable {
  const FacultyEvent();

  @override
  List<Object> get props => [];
}

class GetAllFacultyEvent extends FacultyEvent {}

class GetFacultyDetails extends FacultyEvent {}
