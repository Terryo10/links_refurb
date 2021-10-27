import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/bloc/experties_bloc/experties_bloc.dart';
import 'package:link_refurb/bloc/subscription_bloc/subscription_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/repositories/cache_repository/cache_repository.dart';

import 'package:meta/meta.dart';

part 'cache_bloc_event.dart';
part 'cache_bloc_state.dart';

class CacheBloc extends Bloc<CacheBlocEvent, CacheBlocState> {
  final CacheRepository cacheRepository;
  final UserBloc userBloc;
  final SubscriptionBloc subscriptionBloc ;
   final ExpertiesBloc expertiesBloc;
  CacheBloc( {
    required this.subscriptionBloc,
    required this.cacheRepository,
    required this.userBloc,
    required this.expertiesBloc,
  }) : super(CacheBlocInitial());

  @override
  Stream<CacheBlocState> mapEventToState(
    CacheBlocEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      //check token availability
      try {
        print('checking token');
        var token = await cacheRepository.getAuthToken();
        //fetching user data
        yield CacheFoundState(token: token);
        userBloc.add(GetUserDataEvent());
        expertiesBloc.add(FetchExpertiesList());
        subscriptionBloc.add(GetPriceEvent());
      } catch (e) {
        print('user_token not found proceed to login');
        yield CacheNotFoundState();
      }
    }
  }
}
