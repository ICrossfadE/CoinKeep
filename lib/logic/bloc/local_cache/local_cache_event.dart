part of 'local_cache_bloc.dart';

abstract class LocalCacheEvent extends Equatable {
  const LocalCacheEvent();

  @override
  List<Object> get props => [];
}

class CacheStarted extends LocalCacheEvent {}

class SearchCoinsByName extends LocalCacheEvent {
  final String query;

  SearchCoinsByName(this.query);
}
