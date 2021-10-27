

import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/repositories/jobs_repository/jobs_provider.dart';

class JobsRepository {
  final JobsProvider provider;

  JobsRepository({required this.provider});

  Future<JobsModel> getUserJobsList() async {
    var jobs = await provider.getUserJobsList();

    return jobsModelFromJson(jobs);
  }

  Future<JobsModel> getUserAppliedJobs()async{
    var jobs = await provider.getUserAppliedJobs();
    return jobsModelFromJson(jobs);
  }
}
