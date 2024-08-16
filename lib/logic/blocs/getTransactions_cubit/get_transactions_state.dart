part of 'get_transactions_cubit.dart';

class GetTransactionsState extends Equatable {
  const GetTransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionState extends Equatable {
  final List<TransactionsModel> transactions;
  final List<AssetModel> assets;

  const TransactionState({
    required this.transactions,
    required this.assets,
  });

  TransactionState copyWith({
    List<TransactionsModel>? transactions,
    List<AssetModel>? assets,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      assets: assets ?? this.assets,
    );
  }

  @override
  List<Object> get props => [transactions, assets];
}
