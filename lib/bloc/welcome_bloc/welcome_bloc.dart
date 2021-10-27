import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial());

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if(event is WelcomeLoginEvent){
      yield WelcomeLoginState();
    }

    if(event is WelcomeRegisterEvent){
      yield WelcomeRegisterState();
    }

    if(event is WelcomeResetEvent){
      yield WelcomeInitial();
    }
  }
}
