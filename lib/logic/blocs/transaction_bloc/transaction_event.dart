part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends TransactionEvent {
  const Initial();
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

final class Submit extends TransactionEvent {
  // final String newDate;
  const Submit();
}
