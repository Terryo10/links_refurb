part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class PostNewPassword extends ChangePasswordEvent{
  final String oldPassword;
  final String newPassword;

  PostNewPassword({required this.oldPassword, required this.newPassword});
}
