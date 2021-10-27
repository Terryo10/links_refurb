import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/models/experties_model/expertise_model.dart';
import 'package:link_refurb/models/messsage_model/message.dart';
import 'package:link_refurb/repositories/expertise_repository/experties_repository.dart';

import 'package:meta/meta.dart';

part 'experties_bloc_event.dart';
part 'experties_bloc_state.dart';

class ExpertiesBloc extends Bloc<ExpertiesEvent, ExpertiesBlocState> {
  final ExpertiseRepository expertiseRepository;
  final UserBloc userBloc;
  ExpertiesBloc({required this.expertiseRepository, required this.userBloc})
      : super(ExpertiesBlocInitial());

  @override
  Stream<ExpertiesBlocState> mapEventToState(
    ExpertiesEvent event,
  ) async* {
    if (event is FetchExpertiesList) {
      yield ExpertiseLoadingState();
      try {
        var data = await expertiseRepository.getExpertiesList();
        yield ExpertiseLoadedState(expertiseListModel: data);
      } catch (e) {
        yield ExpertiseErrorState(message: e.toString());
      }
    }

    if (event is AssignExpertiesToUser) {
      yield ExpertiseLoadingState();
      try {
        var messageModel = await expertiseRepository.selectExperties(
            expertiseId: event.expertiesId);

        yield ExpertiseUpdatedState(messageModel: messageModel);
        userBloc.add(GetUserDataEvent());
      } catch (e) {
        yield ExpertiseErrorState(message: e.toString());
      }
    }

     if (event is ChangeExperties) {
      yield ExpertiseLoadingState();
      try {
        var messageModel = await expertiseRepository.changeExperties(
            expertiseId: event.expertiesId);

        yield ExpertiseUpdatedState(messageModel: messageModel);
        userBloc.add(GetUserDataEvent());
      } catch (e) {
        yield ExpertiseErrorState(message: e.toString());
      }
    }
  }
}
