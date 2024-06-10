part of 'local_cache_bloc.dart';

enum CacheStatus { initial, loading, success, error }

class LocalCacheState extends Equatable {
  final CoinModel? coinModel; // Змінено з List<CoinModel> на CoinModel
  final CacheStatus status;

  const LocalCacheState({
    this.coinModel,
    this.status = CacheStatus.initial,
  });

  LocalCacheState copyWith({
    CoinModel? coinModel, // Змінено з List<CoinModel> на CoinModel
    CacheStatus? status,
  }) {
    return LocalCacheState(
      coinModel: coinModel ?? this.coinModel,
      status: status ?? this.status,
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
      );
    } catch (error) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'data': coinModel?.toJson(),
      'status': status.name
    }; // Поправлено збереження даних про монету
  }

  @override
  List<Object?> get props => [coinModel, status];
}

class LocalCacheInitial extends LocalCacheState {}

class TransactionsLoading extends LocalCacheState {}
