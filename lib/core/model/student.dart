import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/core/model/role.dart';

class StudentModel extends BaseUser {
  final String parentMobileNumber;

  const StudentModel(
      {required String id,
      required String mobileNumber,
      required String firstName,
      required String lastName,
      required this.parentMobileNumber,
      required String defaultPassword})
      : super(
            id: id,
            role: UserRole.student,
            mobileNumber: mobileNumber,
            firstName: firstName,
            lastName: lastName,
            defaultPassword: defaultPassword);

  StudentModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            mobileNumber: json['mobileNumber'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            parentMobileNumber: json['parentMobileNumber'],
            defaultPassword: json['defaultPassword']);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'mobileNumber': mobileNumber,
        'firstName': firstName,
        'lastName': lastName,
        'parentMobileNumber': parentMobileNumber,
        'defaultPassword': defaultPassword
      };

  @override
  List<Object?> get props =>
      [id, mobileNumber, firstName, lastName, parentMobileNumber];
}
