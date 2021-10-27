part of 'applications_bloc.dart';

@immutable
abstract class ApplicationsEvent {}

class JobApplication extends ApplicationsEvent{
  final jobId;

  JobApplication({required this.jobId});
}

class Reset extends ApplicationsEvent{
  
}
