part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState{

}


class UserLoadedState extends UserState{ 
  final UserModel userModel;
  final JobsModel  jobs;

  UserLoadedState({required this.userModel, required this.jobs});
}

class UserErrorState extends UserState{
final String message;

  UserErrorState({required this.message});
}



