import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final String classId;
  final String subjectCode;
  final String studentId;
  final DateTime timestamp;

  const AttendanceModel(
      {required this.classId,
      required this.subjectCode,
      required this.studentId,
      required this.timestamp});

  @override
  List<Object?> get props => [classId, subjectCode, studentId, timestamp];
}
