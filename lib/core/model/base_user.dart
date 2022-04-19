import 'package:equatable/equatable.dart';
import 'role.dart';

abstract class BaseUser extends Equatable {
  final String id;
  final UserRole role;
  final String mobileNumber;
  final String firstName;
  final String lastName;
  final String defaultPassword;

  const BaseUser(
      {required this.id,
      required this.role,
      required this.mobileNumber,
      required this.firstName,
      required this.lastName,
      required this.defaultPassword});
}
