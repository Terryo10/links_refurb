part of 'cache_bloc.dart';

@immutable
abstract class CacheBlocState {}

class CacheBlocInitial extends CacheBlocState {}


class CacheFoundState extends CacheBlocState{
  final String token;

  CacheFoundState({required this.token});
}

class CacheNotFoundState extends CacheBlocState{}