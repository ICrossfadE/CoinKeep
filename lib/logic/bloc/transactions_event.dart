part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class GetCoins extends TransactionsEvent {}

class SearchCoins extends TransactionsEvent {
  final String query;

  SearchCoins({required this.query});
}
