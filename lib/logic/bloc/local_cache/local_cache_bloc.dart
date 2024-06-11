import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:CoinKeep/data/repositories/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_cache_event.dart';
part 'local_cache_state.dart';

final ApiRepository _apiRepository = ApiRepository();

class LocalCacheBloc extends HydratedBloc<LocalCacheEvent, LocalCacheState> {
  LocalCacheBloc() : super(LocalCacheState()) {
    on<CacheStarted>(_onStarted);
    on<SearchCoinsByName>(_searchCoinsByName);
  }

  void _onStarted(CacheStarted event, Emitter<LocalCacheState> emit) async {
    emit(state.copyWith(status: CacheStatus.loading));
    try {
      final responseCoinData = await _apiRepository.fetchCoins();
      if (responseCoinData != null) {
        emit(state.copyWith(
            coinModel: responseCoinData,
            status: CacheStatus.success,
            filteredCoins: responseCoinData.data));
      } else {
        emit(state.copyWith(status: CacheStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: CacheStatus.error));
    }
  }

  void _searchCoinsByName(
      SearchCoinsByName event, Emitter<LocalCacheState> emit) {
    final filteredCoins = state.coinModel?.data
        ?.where((coin) =>
            coin.name!.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(state.copyWith(filteredCoins: filteredCoins));
  }

  @override
  LocalCacheState? fromJson(Map<String, dynamic> json) {
    return LocalCacheState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LocalCacheState state) {
    return state.toJson();
  }
}
