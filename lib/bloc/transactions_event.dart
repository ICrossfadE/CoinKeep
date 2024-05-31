part of 'transactions_bloc.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

// class TransactionsStarted extends TransactionsEvent {}

class GetCoins extends TransactionsEvent {
  // final Coin coins;

  // @override
  // List<Object> get props => [coins];
}
