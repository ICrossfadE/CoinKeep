part of 'get_transactions_cubit.dart';

class GetTransactionsState extends Equatable {
  final List<TransactionEntity> transactions;
  final List<AssetModel> assets;

  const GetTransactionsState({
    this.transactions = const [],
    this.assets = const [],
  });

  GetTransactionsState copyWith({
    List<TransactionEntity>? transactions,
    List<AssetModel>? assets,
  }) {
    return GetTransactionsState(
      transactions: transactions ?? this.transactions,
      assets: assets ?? this.assets,
    );
  }

  @override
  List<Object> get props => [transactions, assets];
}
