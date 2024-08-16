part of 'get_transactions_cubit.dart';

class GetTransactionsState extends Equatable {
  const GetTransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionState extends Equatable {
  final List<TransactionsModel> transactions;
  final List<TransactionsModel> assets;

  const TransactionState({
    required this.transactions,
    required this.assets,
  });

  TransactionState copyWith({
    List<TransactionsModel>? transactions,
    List<TransactionsModel>? assets,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      assets: assets ?? this.assets,
    );
  }

  @override
  List<Object> get props => [transactions, assets];
}

class GetTransactionsLoaded extends GetTransactionsState {
  final List<TransactionsModel> transactions;

  const GetTransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}
