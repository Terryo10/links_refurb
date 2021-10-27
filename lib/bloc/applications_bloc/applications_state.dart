part of 'applications_bloc.dart';

@immutable
abstract class ApplicationsState {}

class ApplicationsInitial extends ApplicationsState {}

class ApplicationLoadingState extends ApplicationsState {}

class JobAppliedState extends ApplicationsState{
  final MessageModel messageModel;

  JobAppliedState({required this.messageModel});
}

class ApplicationErrorState extends ApplicationsState{
final String message;

  ApplicationErrorState({required this.message});

}