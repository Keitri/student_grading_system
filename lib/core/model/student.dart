import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/core/model/role.dart';

class StudentModel extends BaseUser {
  final String parentMobileNumber;

  const StudentModel(
      {required String id,
      required String mobileNumber,
      required String firstName,
      required String lastName,
      required this.parentMobileNumber})
      : super(
            id: id,
            role: UserRole.student,
            mobileNumber: mobileNumber,
            firstName: firstName,
            lastName: lastName);

  @override
  List<Object?> get props =>
      [id, mobileNumber, firstName, lastName, parentMobileNumber];
}
