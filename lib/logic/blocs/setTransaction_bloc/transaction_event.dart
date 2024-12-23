part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends TransactionEvent {}

class InitializeAfterReset extends TransactionEvent {}

final class Create extends TransactionEvent {
  const Create();
}

class ResetState extends TransactionEvent {
  final String name;
  final double amount;
  final double price;
  final String typeTrade;
  final String selectedWallet;
  final DateTime date;

  const ResetState(
    this.name,
    this.amount,
    this.price,
    this.typeTrade,
    this.selectedWallet,
    this.date,
  );
}

final class UpdateIcon extends TransactionEvent {
  // Може бути null
  final int? iconId;
  const UpdateIcon(this.iconId);
}

final class UpdateName extends TransactionEvent {
  final String name;
  const UpdateName(this.name);
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

final class UpdateWalletId extends TransactionEvent {
  final String newWalletId;
  const UpdateWalletId(this.newWalletId);
}

final class UpdateTrade extends TransactionEvent {
  final String newTypeTraide;
  const UpdateTrade(this.newTypeTraide);
}

class Update extends TransactionEvent {
  final String transactionId;
  final String? newIconId;
  final String? name;
  final String? newSymbol;
  final double? newAmount;
  final double? newPrice;
  final String? newTypeTrade;
  final String? newWalletId;
  final DateTime? newDate;

  const Update({
    required this.transactionId,
    this.newIconId,
    this.name,
    this.newSymbol,
    this.newWalletId,
    this.newAmount,
    this.newPrice,
    this.newTypeTrade,
    this.newDate,
  });
}

class DeleteTransaction extends TransactionEvent {
  final String? transactionId;

  const DeleteTransaction(this.transactionId);

  @override
  List<Object> get props => [];
}
