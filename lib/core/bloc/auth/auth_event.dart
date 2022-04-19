part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String mobileNumber;
  final String password;

  const LoginEvent({required this.mobileNumber, required this.password});
}

class AutoLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String mobileNumber;

  const ResetPasswordEvent({required this.mobileNumber});
}
