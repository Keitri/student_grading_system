import 'package:equatable/equatable.dart';

class GradeModel extends Equatable {
  final String subjectCode;
  final String studentId;
  final String facultyId;
  final DateTime createDate;
  final DateTime updateDate;
  final Map<String, double> grades;

  const GradeModel(
      {required this.subjectCode,
      required this.studentId,
      required this.facultyId,
      required this.createDate,
      required this.updateDate,
      required this.grades});

  @override
  List<Object?> get props =>
      [subjectCode, studentId, facultyId, createDate, updateDate, grades];
}
