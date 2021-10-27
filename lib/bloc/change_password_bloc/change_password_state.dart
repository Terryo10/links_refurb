part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangeLoadingState extends ChangePasswordState {}

class ChangeLoadedState extends ChangePasswordState {
  final MessageModel messageModel;

  ChangeLoadedState({required this.messageModel});
}

class ChangePasswordErrorState extends ChangePasswordState{
  final String message;

  ChangePasswordErrorState({required this.message});
}
