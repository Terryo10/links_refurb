import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/bloc/jobs_bloc/jobs_bloc.dart';
import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/models/user_model/user_model.dart';
import 'package:link_refurb/repositories/user_repository/user_repository.dart';

import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final JobsBloc jobsBloc;
  UserBloc({required this.userRepository, required this.jobsBloc})
      : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserDataEvent) {
      print('getting user data');
      yield UserLoadingState();
      try {
        var userData = await userRepository.getUserData();
        var appliedJobs = await userRepository.getAppliedJobs();
        print('user data found');
        yield UserLoadedState(
            userModel: userData, jobs: appliedJobs);
        if (userData.data!.expertise != null && userData.data!.cvFile != null) {
          jobsBloc.add(FetchUserJobs());
        }
      } catch (e) {
        yield UserErrorState(message: e.toString());
      }
    }

    
  }
}
