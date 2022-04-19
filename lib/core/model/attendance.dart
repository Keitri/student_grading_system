import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final String id;
  final String classId;
  final String subjectCode;
  final String studentId;
  final DateTime timestamp;

  const AttendanceModel(
      {required this.classId,
      required this.id,
      required this.subjectCode,
      required this.studentId,
      required this.timestamp});

  AttendanceModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            classId: json['classId'],
            subjectCode: json['subjectCode'],
            studentId: json['studentId'],
            timestamp: json['timestamp']);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'classId': classId,
        'subjectCode': subjectCode,
        'studentId': studentId,
        'timestamp': timestamp
      };

  @override
  List<Object?> get props => [id, classId, subjectCode, studentId, timestamp];
}
