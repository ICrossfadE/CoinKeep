part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final String uid;
  final int iconId;
  final String symbol;
  final double amount;
  final double price;
  final double sum;
  final String typeTrade;
  final String selectedWallet;
  final DateTime date;

  TransactionState({
    this.uid = '',
    this.iconId = 0,
    this.symbol = '',
    this.amount = 0.0,
    this.price = 0.0,
    this.sum = 0.0,
    this.typeTrade = '',
    this.selectedWallet = '',
    DateTime? date,
  }) : date = date ?? DateTime.now();

  TransactionState copyWith({
    String? uid,
    int? iconId,
    String? symbol,
    double? amount,
    double? price,
    double? sum,
    String? typeTrade,
    String? selectedWallet,
    DateTime? date,
  }) {
    return TransactionState(
      uid: uid ?? this.uid,
      iconId: iconId ?? this.iconId,
      symbol: symbol ?? this.symbol,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      sum: sum ?? this.sum,
      typeTrade: typeTrade ?? this.typeTrade,
      selectedWallet: selectedWallet ?? this.selectedWallet,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [
        uid,
        iconId,
        symbol,
        amount,
        price,
        sum,
        typeTrade,
        selectedWallet,
        date
      ];
}

final class TransactionInitial extends TransactionState {}
