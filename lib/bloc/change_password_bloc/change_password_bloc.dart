import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/models/messsage_model/message.dart';
import 'package:link_refurb/repositories/user_repository/user_repository.dart';

import 'package:meta/meta.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;
  ChangePasswordBloc({required this.userRepository}) : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if(event is PostNewPassword){
      yield ChangeLoadingState();
      try{
        var data = await userRepository.changePassword(oldPassword: event.oldPassword, newPassword: event.newPassword);
        yield ChangeLoadedState(messageModel: data);
      }catch(e){
        yield ChangePasswordErrorState(message: e.toString());
      }
    }
  }
}
