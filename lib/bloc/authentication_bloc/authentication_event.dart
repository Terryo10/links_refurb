part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginButtonPressedEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent({required this.email, required this.password});
}

class RegistrationButtonPressedEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegistrationButtonPressedEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.confirmPassword});
}

class  AppLogoutEvent extends AuthenticationEvent{}
