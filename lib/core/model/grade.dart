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

  GradeModel.map(Map<String, dynamic> json)
      : this(
            subjectCode: json['subjectCode'],
            studentId: json['studentId'],
            facultyId: json['facultyId'],
            createDate: json['createDate'],
            updateDate: json['updateDate'],
            grades: json['grades']);

  Map<String, dynamic> toJSON() => {
        'subjectCode': subjectCode,
        'studentId': studentId,
        'facultyId': facultyId,
        'createDate': createDate,
        'updateDate': updateDate,
        'grades': grades
      };

  @override
  List<Object?> get props =>
      [subjectCode, studentId, facultyId, createDate, updateDate, grades];
}
