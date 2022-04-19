import 'package:equatable/equatable.dart';
import '../helpers/json.dart';

class SubjectModel extends Equatable {
  final String id;
  final String code;
  final String description;
  final double units;
  final String facultyId;
  final List<String> categories;
  final List<String> studentIds;

  const SubjectModel(
      {required this.code,
      required this.id,
      required this.description,
      required this.units,
      required this.facultyId,
      required this.categories,
      required this.studentIds});

  SubjectModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            code: json['code'],
            description: json['description'],
            units: json['units'],
            facultyId: json['facultyId'],
            categories: JsonHelper.dynamicListToString(json['categories']),
            studentIds: JsonHelper.dynamicListToString(json['studentIds']));

  Map<String, dynamic> toJSON() => {
        'id': id,
        'code': code,
        'description': description,
        'units': units,
        'facultyId': facultyId,
        'categories': categories,
        'studentIds': studentIds
      };

  @override
  List<Object?> get props =>
      [id, code, description, units, facultyId, categories, studentIds];
}
