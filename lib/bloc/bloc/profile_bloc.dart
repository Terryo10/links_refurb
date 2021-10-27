import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/models/messsage_model/message.dart';
import 'package:link_refurb/repositories/user_repository/user_repository.dart';

import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserBloc userBloc;
  final UserRepository userRepository;
  ProfileBloc({required this.userBloc, required this.userRepository})
      : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is CreateProfileEvent) {
      yield ProfileLoadingState();
      try {
        var data = await userRepository.createProfile(
            phoneNumber: event.phoneNumber, image: event.image);
        userBloc.add(GetUserDataEvent());
        yield ProfileLoadedState(messageModel: data);
      } catch (err) {
        yield ProfileErrorState(message: err.toString());
      }
    }

    if (event is DeleteProfileEvent) {
      yield ProfileLoadingState();
      try {
        var data = await userRepository.deleteProfile();
        userBloc.add(GetUserDataEvent());
        yield ProfileLoadedState(messageModel: data);
      } catch (err) {
        yield ProfileErrorState(message: err.toString());
      }
    }
  }
}
