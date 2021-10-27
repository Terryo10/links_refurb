part of 'experties_bloc.dart';

@immutable
abstract class ExpertiesBlocState {}

class ExpertiesBlocInitial extends ExpertiesBlocState {}

class ExpertiseLoadingState extends ExpertiesBlocState {}

class ExpertiseUpdatedState extends ExpertiesBlocState {
  final MessageModel messageModel;

  ExpertiseUpdatedState({required this.messageModel});
}

class ExpertiseLoadedState extends ExpertiesBlocState {
  final ExpertiseListModel expertiseListModel;
  ExpertiseLoadedState({required this.expertiseListModel});
}

class ExpertiseErrorState extends ExpertiesBlocState {
  final String message;

  ExpertiseErrorState({required this.message});
}
