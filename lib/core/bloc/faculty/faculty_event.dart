part of 'faculty_bloc.dart';

abstract class FacultyEvent extends Equatable {
  const FacultyEvent();

  @override
  List<Object> get props => [];
}

class GetAllFacultyEvent extends FacultyEvent {}

class GetFacultyDetails extends FacultyEvent {}

class LoadFacultyList extends FacultyEvent {}

class SaveNewFacultyUser extends FacultyEvent {
  final FacultyModel newUser;

  const SaveNewFacultyUser({required this.newUser});
}
