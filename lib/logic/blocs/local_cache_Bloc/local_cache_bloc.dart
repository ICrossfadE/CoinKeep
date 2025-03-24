import 'package:CoinKeep/src/data/models/coin_model.dart';
import 'package:CoinKeep/src/data/network/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_cache_event.dart';
part 'local_cache_state.dart';

final ApiRepository _apiRepository = ApiRepository();
int _failureCount = 0;

//Клас розширений HydratedBloc Для кешування даних
class LocalCacheBloc extends HydratedBloc<LocalCacheEvent, LocalCacheState> {
  LocalCacheBloc() : super(const LocalCacheState()) {
    //Події
    on<CacheStarted>(_onStarted);
    on<ResetSearch>(_resetSearch);
    on<SearchCoinsByName>(_searchCoinsByName);
    on<RetryFetchCoins>(_onRetryFetchCoins);
  }

  void _onStarted(CacheStarted event, Emitter<LocalCacheState> emit) async {
    // Якщо є попередні кешовані дані, показуємо їх
    if (state.coinModel != null && state.status == CacheStatus.success) {
      emit(state.copyWith(status: CacheStatus.success));
    }

    emit(state.copyWith(status: CacheStatus.loading));

    try {
      final responseCoinData = await _apiRepository.fetchCoins();

      // Перевірка на наявність помилки в даних
      if (responseCoinData.error != null) {
        // Якщо попередні дані існують, використовуємо їх
        if (state.coinModel != null) {
          emit(state.copyWith(
              status: CacheStatus.success,
              errorMessage: responseCoinData.error));
        } else {
          emit(state.copyWith(
              status: CacheStatus.error, errorMessage: responseCoinData.error));
        }
      } else {
        emit(state.copyWith(
          coinModel: responseCoinData,
          status: CacheStatus.success,
          filteredCoins: responseCoinData.data,
          errorMessage: null,
        ));
      }
    } catch (error) {
      // Якщо попередні дані існують, використовуємо їх
      if (state.coinModel != null) {
        emit(state.copyWith(
            status: CacheStatus.success,
            errorMessage: 'Помилка оновлення даних'));
      } else {
        emit(state.copyWith(
            status: CacheStatus.error,
            errorMessage: 'Unexpected error occurred'));
      }
    }
  }

  void _onRetryFetchCoins(
      RetryFetchCoins event, Emitter<LocalCacheState> emit) {
    add(CacheStarted());
  }

  void _resetSearch(ResetSearch event, Emitter<LocalCacheState> emit) {
    emit(state.copyWith(filteredCoins: state.coinModel?.data));
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
