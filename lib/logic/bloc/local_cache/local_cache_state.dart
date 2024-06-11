part of 'local_cache_bloc.dart';

enum CacheStatus { initial, loading, success, error }

class LocalCacheState extends Equatable {
  final CoinModel? coinModel;
  final CacheStatus status; // Для відстеження статусу кешування
  final List<Data>? filteredCoins; //Список відфільтрованих монет

  //Constructor
  const LocalCacheState({
    this.coinModel,
    this.status = CacheStatus.initial,
    this.filteredCoins,
  });

  // Метод копіювання обєкту LocalCacheState зі зміненими значеннями
  LocalCacheState copyWith({
    CoinModel? coinModel,
    CacheStatus? status,
    List<Data>? filteredCoins,
  }) {
    return LocalCacheState(
      coinModel: coinModel ?? this.coinModel,
      status: status ?? this.status,
      filteredCoins: filteredCoins ?? this.filteredCoins,
    );
  }

  @override
  // Сеалізація данних
  factory LocalCacheState.fromJson(Map<String, dynamic> json) {
    try {
      return LocalCacheState(
        coinModel: CoinModel.fromJson(json['data']),
        status: CacheStatus.values
            .firstWhere((element) => element.name.toString() == json['status']),
        filteredCoins: (json['filteredCoins'] as List<dynamic>?)
            ?.map((element) => Data.fromJson(element as Map<String, dynamic>))
            .toList(),
      );
    } catch (error) {
      rethrow;
    }
  }

  // Десеалізація данних
  Map<String, dynamic> toJson() {
    return {
      'data': coinModel?.toJson(),
      'status': status.name,
      'filteredCoins': filteredCoins?.map((e) => e.toJson()).toList(),
    };
  }

  //Метод властивостей об'єкта, які використовуються для порівняння об'єктів. (Equatable)
  @override
  List<Object?> get props => [coinModel, status, filteredCoins];
}
