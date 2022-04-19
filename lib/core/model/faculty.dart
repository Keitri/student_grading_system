import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/core/model/role.dart';

class FacultyModel extends BaseUser {
  const FacultyModel(
      {required String id,
      required String mobileNumber,
      required String firstName,
      required String lastName})
      : super(
            role: UserRole.faculty,
            id: id,
            mobileNumber: mobileNumber,
            firstName: firstName,
            lastName: lastName);

  @override
  List<Object?> get props => [id, mobileNumber, firstName, lastName];
}
