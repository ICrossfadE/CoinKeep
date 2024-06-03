part of 'transactions_bloc.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final CoinModel coinModel;
  const TransactionsLoaded(this.coinModel);

  // @override
  // List<Object> get props => [coinModel];
}

class TransactionsError extends TransactionsState {
  final String? error;
  const TransactionsError(this.error);

  // @override
  // List<Object> get props => [error];
}
