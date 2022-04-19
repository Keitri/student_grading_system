part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final BaseUser currentUser;

  const Authenticated({required this.currentUser});
}

class AuthPasswordChanged extends AuthState {}

class AuthPasswordChangeError extends AuthState {
  final String errorMessage;

  const AuthPasswordChangeError({required this.errorMessage});
}

class AuthError extends AuthState {}
