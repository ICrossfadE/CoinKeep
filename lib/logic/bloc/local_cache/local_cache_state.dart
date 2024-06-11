part of 'local_cache_bloc.dart';

enum CacheStatus { initial, loading, success, error }

class LocalCacheState extends Equatable {
  final CoinModel? coinModel; // Змінено з List<CoinModel> на CoinModel
  final CacheStatus status;
  final List<Data>? filteredCoins;

  const LocalCacheState({
    this.coinModel,
    this.status = CacheStatus.initial,
    this.filteredCoins,
  });

  LocalCacheState copyWith({
    CoinModel? coinModel, // Змінено з List<CoinModel> на CoinModel
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
  factory LocalCacheState.fromJson(Map<String, dynamic> json) {
    try {
      return LocalCacheState(
        coinModel: CoinModel.fromJson(
            json['data']), // Поправлено отримання даних про монету
        status: CacheStatus.values
            .firstWhere((element) => element.name.toString() == json['status']),
        filteredCoins: (json['filteredCoins'] as List<dynamic>?)
            ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (error) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'data': coinModel?.toJson(),
      'status': status.name,
      'filteredCoins': filteredCoins?.map((e) => e.toJson()).toList(),
    }; // Поправлено збереження даних про монету
  }

  @override
  List<Object?> get props => [coinModel, status, filteredCoins];
}

class LocalCacheInitial extends LocalCacheState {}

class TransactionsLoading extends LocalCacheState {}
