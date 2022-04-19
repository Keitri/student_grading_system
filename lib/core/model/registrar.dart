import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/core/model/role.dart';

class RegistrarModel extends BaseUser {
  const RegistrarModel(
      {required String id,
      required String mobileNumber,
      required String firstName,
      required String lastName,
      required String defaultPassword})
      : super(
            id: id,
            role: UserRole.registrar,
            mobileNumber: mobileNumber,
            firstName: firstName,
            lastName: lastName,
            defaultPassword: defaultPassword);

  RegistrarModel.map(Map<String, dynamic> json)
      : this(
            id: json['id'],
            mobileNumber: json['mobileNumber'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            defaultPassword: json['defaultPassword']);

  Map<String, dynamic> toJSON() => {
        'id': id,
        'mobileNumber': mobileNumber,
        'firstName': firstName,
        'lastName': lastName,
        'defaultPassword': defaultPassword
      };

  @override
  List<Object?> get props => [id, mobileNumber, firstName, lastName];
}
