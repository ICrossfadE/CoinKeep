import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:CoinKeep/data/network/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_cache_event.dart';
part 'local_cache_state.dart';

final ApiRepository _apiRepository = ApiRepository();

//Клас розширений HydratedBloc Для кешування даних
class LocalCacheBloc extends HydratedBloc<LocalCacheEvent, LocalCacheState> {
  // Початковий стан (super(const LocalCacheState()))
  LocalCacheBloc() : super(const LocalCacheState()) {
    //Події
    on<CacheStarted>(_onStarted);
    on<SearchCoinsByName>(_searchCoinsByName);
  }

  //Отримання даних та кешування
  void _onStarted(CacheStarted event, Emitter<LocalCacheState> emit) async {
    emit(state.copyWith(status: CacheStatus.loading));
    try {
      final responseCoinData = await _apiRepository.fetchCoins();
      emit(state.copyWith(
        coinModel: responseCoinData,
        status: CacheStatus.success,
        filteredCoins: responseCoinData.data,
      ));
    } catch (error) {
      emit(state.copyWith(status: CacheStatus.error));
    }
  }

  // Пошук за іменем
  void _searchCoinsByName(
      SearchCoinsByName event, Emitter<LocalCacheState> emit) {
    final filteredCoins = state.coinModel?.data
        // Метод фільтрування за полем name
        ?.where((coin) =>
            coin.name!.toLowerCase().contains(event.query.toLowerCase()))
        .toList(); //Перетворення в масив
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
