import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/models/messsage_model/message.dart';
import 'package:link_refurb/repositories/user_repository/user_repository.dart';

import 'package:meta/meta.dart';

part 'applications_event.dart';
part 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final UserRepository userRepository;
  ApplicationsBloc({required this.userRepository})
      : super(ApplicationsInitial());

  @override
  Stream<ApplicationsState> mapEventToState(
    ApplicationsEvent event,
  ) async* {
    if (event is JobApplication) {
      print('Applying');
      yield ApplicationLoadingState();
      try {
        var userData = await userRepository.jobApplication(jobId: event.jobId);
        print('applied well');
        yield JobAppliedState(messageModel: userData);
      } catch (e) {
        yield ApplicationErrorState(message: e.toString());
      }
    }
    if (event is Reset) {
      yield ApplicationsInitial();
    }


  }
}
