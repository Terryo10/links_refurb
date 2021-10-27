part of 'single_job_bloc.dart';

@immutable
abstract class SingleJobEvent {}

class FetchJobEvent extends SingleJobEvent {
  final id;
  FetchJobEvent({required this.id});
}
