part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class StartLoginEvent extends LoginEvent {
  final String mobileNumber;
  final String password;

  const StartLoginEvent({required this.mobileNumber, required this.password});
}
