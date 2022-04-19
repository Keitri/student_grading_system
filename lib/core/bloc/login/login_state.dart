part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final BaseUser currentUser;

  const LoginSuccess({required this.currentUser});
}

class LoginError extends LoginState {
  final String errorMessage;
  const LoginError({required this.errorMessage});
}

class LoginLoading extends LoginState {}
