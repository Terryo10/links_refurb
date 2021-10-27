part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeEvent {}

class WelcomeLoginEvent extends WelcomeEvent{}

class WelcomeRegisterEvent extends WelcomeEvent{}

class WelcomeResetEvent extends WelcomeEvent{}
