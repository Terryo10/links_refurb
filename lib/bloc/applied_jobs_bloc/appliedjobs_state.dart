part of 'appliedjobs_bloc.dart';

@immutable
abstract class AppliedjobsState {}

class AppliedjobsInitialState extends AppliedjobsState {}

class AppliedjobsLoadingState extends AppliedjobsState {}

class AppliedjobsILoadedState extends AppliedjobsState {
  final JobsModel jobsModel;

  AppliedjobsILoadedState({required this.jobsModel});
}

class AppliedjobsErrorState extends AppliedjobsState {
  final String message;

  AppliedjobsErrorState({required this.message});

}
