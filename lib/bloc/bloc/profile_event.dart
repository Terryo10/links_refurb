part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class CreateProfileEvent extends ProfileEvent {
  final String phoneNumber;
  final File image;

  CreateProfileEvent({required this.phoneNumber, required this.image});
}

class DeleteProfileEvent extends ProfileEvent {}
