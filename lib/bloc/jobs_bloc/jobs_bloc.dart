import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/repositories/jobs_repository/jobs_repository.dart';

import 'package:meta/meta.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final JobsRepository jobsRepository;
  JobsBloc({required this.jobsRepository}) : super(JobsInitial());

  @override
  Stream<JobsState> mapEventToState(
    JobsEvent event,
  ) async* {
    if (event is FetchUserJobs) {
      try {
        yield JobsLoadingState();
        var response = await jobsRepository.getUserJobsList();
        yield JobsLoadedState(jobsModel: response);
      } catch (k) {
        yield JobsErrorState(message: k.toString());
      }
    }
  }
}
