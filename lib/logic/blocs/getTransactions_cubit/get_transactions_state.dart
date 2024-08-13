part of 'get_transactions_cubit.dart';

class GetTransactionsState extends Equatable {
  const GetTransactionsState();

  @override
  List<Object> get props => [];
}

class GetTransactionsInitial extends GetTransactionsState {}

class GetTransactionsLoaded extends GetTransactionsState {
  final List<TransactionsModel> transactions;

  const GetTransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}
