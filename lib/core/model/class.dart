import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/helpers/timestamp.dart';

import '../helpers/json.dart';

class ClassModel extends Equatable {
  final String id;
  final String subjectId;
  final String facultyId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<String> studentIds;

  const ClassModel(
      {required this.id,
      required this.subjectId,
      required this.facultyId,
      required this.startTime,
      required this.studentIds,
      this.endTime});

  ClassModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            subjectId: json['subjectId'],
            facultyId: json['facultyId'],
            startTime: (json['startTime'] as Object).fromTimeStampToDateTime(),
            studentIds: JsonHelper.dynamicListToString(json['studentIds']),
            endTime: json['endTime'] != null
                ? (json['endTime'] as Object).fromTimeStampToDateTime()
                : null);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'subjectId': subjectId,
        'facultyId': facultyId,
        'startTime': startTime,
        'studentIds': studentIds,
        'endTime': endTime
      };

  bool studentIdExist(String studentId) {
    try {
      studentIds.firstWhere((s) => s == studentId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<Object?> get props =>
      [id, subjectId, facultyId, startTime, studentIds.length, endTime];
}
