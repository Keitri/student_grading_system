part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AutoLoginEvent extends AuthEvent {}

class AuthenticateEvent extends AuthEvent {
  final BaseUser currentUser;

  const AuthenticateEvent({required this.currentUser});
}

class LogoutEvent extends AuthEvent {}
