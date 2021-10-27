part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationAuthenticatedState extends AuthenticationState{
  final AuthenticationModel authenticationModel;

  AuthenticationAuthenticatedState({required this.authenticationModel});
}

class AuthenticationErrorState extends AuthenticationState{
  final String message;

  AuthenticationErrorState({required this.message});

}