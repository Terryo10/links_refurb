import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_job_event.dart';
part 'single_job_state.dart';

class SingleJobBloc extends Bloc<SingleJobEvent, SingleJobState> {
  SingleJobBloc() : super(SingleJobInitial());

  @override
  Stream<SingleJobState> mapEventToState(
    SingleJobEvent event,
  ) async* {
    
  }
}
