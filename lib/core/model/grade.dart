import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/helpers/timestamp.dart';

class GradeModel extends Equatable {
  final String id;
  final String subjectId;
  final String subjectName;
  final String studentId;
  final String studentName;
  final String facultyId;
  final String parentsMobileNumber;
  final DateTime createDate;
  final double totalGrade;
  final Map<String, dynamic> grades;

  const GradeModel(
      {required this.subjectId,
      required this.subjectName,
      required this.id,
      required this.studentId,
      required this.studentName,
      required this.facultyId,
      required this.createDate,
      required this.totalGrade,
      required this.parentsMobileNumber,
      required this.grades});

  GradeModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            subjectId: json['subjectId'],
            subjectName: json['subjectName'],
            studentId: json['studentId'],
            studentName: json['studentName'],
            facultyId: json['facultyId'],
            parentsMobileNumber: json['parentsMobileNumber'],
            createDate:
                (json['createDate'] as Object).fromTimeStampToDateTime(),
            totalGrade: json['totalGrade'],
            grades: json['grades']);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'studentId': studentId,
        'studentName': studentName,
        'facultyId': facultyId,
        'parentsMobileNumber': parentsMobileNumber,
        'createDate': createDate,
        'totalGrade': totalGrade,
        'grades': grades
      };

  @override
  List<Object?> get props => [
        id,
        subjectId,
        studentId,
        facultyId,
        createDate,
        grades,
        totalGrade,
        subjectName,
        studentName,
        parentsMobileNumber
      ];
}
