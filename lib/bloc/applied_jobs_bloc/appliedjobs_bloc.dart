import 'package:bloc/bloc.dart';
import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/repositories/jobs_repository/jobs_repository.dart';

import 'package:meta/meta.dart';

part 'appliedjobs_event.dart';
part 'appliedjobs_state.dart';

class AppliedjobsBloc extends Bloc<AppliedjobsEvent, AppliedjobsState> {
  final JobsRepository jobsRepository;
  AppliedjobsBloc({required this.jobsRepository}) : super(AppliedjobsInitialState());

  @override
  Stream<AppliedjobsState> mapEventToState(AppliedjobsEvent event) async* {
    if (event is GetAppliedJobsEvent) {
      yield AppliedjobsLoadingState();
      try{
       var data = await jobsRepository.getUserAppliedJobs();
       yield AppliedjobsILoadedState(jobsModel: data);
      }catch(t){
        yield AppliedjobsErrorState(message: t.toString());
      }
    }
  }
}
