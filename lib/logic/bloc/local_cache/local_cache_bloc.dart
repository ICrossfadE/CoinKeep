import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:CoinKeep/data/repositories/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_cache_event.dart';
part 'local_cache_state.dart';

final ApiRepository _apiRepository = ApiRepository();

class LocalCacheBloc extends HydratedBloc<LocalCacheEvent, LocalCacheState> {
  LocalCacheBloc() : super(LocalCacheInitial()) {
    on<LocalCacheEvent>(_onStarted);
  }

  void _onStarted(LocalCacheEvent event, Emitter<LocalCacheState> emit) async {
    if (state.status == CacheStatus.success) return;
    try {
      final responseCoinData = await _apiRepository.fetchCoins();
      if (responseCoinData != null) {
        emit(state.copyWith(
            coinModel: responseCoinData,
            status: CacheStatus
                .success)); // Виправлено передачу єдиного екземпляра CoinModel
      } else {
        // Handle null response
        emit(state.copyWith(status: CacheStatus.error));
      }
    } catch (e) {
      // Handle error
      emit(state.copyWith(status: CacheStatus.error));
    }
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
