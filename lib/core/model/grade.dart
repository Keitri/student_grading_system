import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/helpers/timestamp.dart';

class GradeModel extends Equatable {
  final String id;
  final String subjectId;
  final String studentId;
  final String facultyId;
  final DateTime createDate;
  final double totalGrade;
  final Map<String, dynamic> grades;

  const GradeModel(
      {required this.subjectId,
      required this.id,
      required this.studentId,
      required this.facultyId,
      required this.createDate,
      required this.totalGrade,
      required this.grades});

  GradeModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            subjectId: json['subjectId'],
            studentId: json['studentId'],
            facultyId: json['facultyId'],
            createDate:
                (json['createDate'] as Object).fromTimeStampToDateTime(),
            totalGrade: json['totalGrade'],
            grades: json['grades']);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'subjectId': subjectId,
        'studentId': studentId,
        'facultyId': facultyId,
        'createDate': createDate,
        'totalGrade': totalGrade,
        'grades': grades
      };

  @override
  List<Object?> get props =>
      [id, subjectId, studentId, facultyId, createDate, grades, totalGrade];
}
