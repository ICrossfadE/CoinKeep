part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends TransactionEvent {
  const Initial();
}

final class UpdateIcon extends TransactionEvent {
  final int iconId;
  const UpdateIcon(this.iconId);
}

final class UpdateSymbol extends TransactionEvent {
  final String symbol;
  const UpdateSymbol(this.symbol);
}

final class UpdatePriceValue extends TransactionEvent {
  final double newPrice;
  const UpdatePriceValue(this.newPrice);
}

final class UpdateAmountValue extends TransactionEvent {
  final double newAmount;
  const UpdateAmountValue(this.newAmount);
}

final class UpdateDate extends TransactionEvent {
  final DateTime newDate;
  const UpdateDate(this.newDate);
}

final class UpdateWallet extends TransactionEvent {
  final String newWallet;
  const UpdateWallet(this.newWallet);
}

final class UpdateTrade extends TransactionEvent {
  final String newTypeTraide;
  const UpdateTrade(this.newTypeTraide);
}

class InitializeData extends TransactionEvent {
  final int iconId;
  final String coinSymbol;
  final double coinPrice;
  final double coinAmount;
  final String coinTypeTraide;
  final String coinWallet;

  const InitializeData({
    required this.iconId,
    required this.coinSymbol,
    required this.coinPrice,
    required this.coinAmount,
    required this.coinTypeTraide,
    required this.coinWallet,
  });
}

final class Create extends TransactionEvent {
  // final String newDate;
  const Create();
}

class Update extends TransactionEvent {
  final String transactionId;
  final String? newIconId;
  final String? newSymbol;
  final double? newAmount;
  final double? newPrice;
  final String? newTypeTrade;
  final String? newWallet;
  final DateTime? newDate;

  const Update({
    required this.transactionId,
    this.newIconId,
    this.newSymbol,
    this.newWallet,
    this.newAmount,
    this.newPrice,
    this.newTypeTrade,
    this.newDate,
  });

  // @override
  // List<Object> get props => [
  //       // transactionId,
  //       // newIconId,
  //       // newSymbol,
  //       // newWallet,
  //       // newAmount,
  //       // newPrice,
  //       // newTypeTrade,
  //       // newDate
  //     ];
}

class Delete extends TransactionEvent {
  final String transactionId;

  const Delete(this.transactionId);

  @override
  List<Object> get props => [transactionId];
}
