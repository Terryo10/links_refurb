part of 'jobs_bloc.dart';

@immutable
abstract class JobsState {}

class JobsInitial extends JobsState {}

class JobsLoadingState extends JobsState {}

class JobsLoadedState extends JobsState {
  final JobsModel jobsModel;

  JobsLoadedState({required this.jobsModel});
}

class JobsErrorState extends JobsState {
  final String message;
  JobsErrorState({required this.message});
}
