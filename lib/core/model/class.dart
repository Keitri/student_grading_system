import 'package:equatable/equatable.dart';

class ClassModel extends Equatable {
  final String id;
  final String subjectCode;
  final String facultyId;
  final DateTime startTime;
  final DateTime? endTime;

  const ClassModel(
      {required this.id,
      required this.subjectCode,
      required this.facultyId,
      required this.startTime,
      this.endTime});

  ClassModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            subjectCode: json['subjectCode'],
            facultyId: json['facultyId'],
            startTime: json['startTime'],
            endTime: json['endTime']);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'subjectCode': subjectCode,
        'facultyId': facultyId,
        'startTime': startTime,
        'endTime': endTime
      };

  @override
  List<Object?> get props => [id, subjectCode, facultyId, startTime, endTime];
}
