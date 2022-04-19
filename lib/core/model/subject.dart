import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  final String code;
  final String description;
  final double units;
  final String facultyId;
  final List<String> categories;
  final List<String> studentIds;

  const SubjectModel(
      {required this.code,
      required this.description,
      required this.units,
      required this.facultyId,
      required this.categories,
      required this.studentIds});

  @override
  List<Object?> get props =>
      [code, description, units, facultyId, categories, studentIds];
}
