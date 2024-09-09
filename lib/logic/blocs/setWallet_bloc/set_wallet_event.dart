part of 'set_wallet_bloc.dart';

sealed class SetWalletEvent extends Equatable {
  const SetWalletEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends SetWalletEvent {}

class InitializeAfterReset extends SetWalletEvent {}

final class Create extends SetWalletEvent {
  const Create();
}

class ResetState extends SetWalletEvent {
  final String walletName;
  final String walletColor;

  const ResetState(
    this.walletName,
    this.walletColor,
  );
}

final class UpdateName extends SetWalletEvent {
  final String newWalletName;
  const UpdateName(this.newWalletName);
}

final class UpdateColor extends SetWalletEvent {
  final String newWalletColor;
  const UpdateColor(this.newWalletColor);
}

class Update extends SetWalletEvent {
  final String walletId;
  final String? newWalletName;
  final String? newWalletColor;

  const Update({
    required this.walletId,
    this.newWalletName,
    this.newWalletColor,
  });
}

class Delete extends SetWalletEvent {
  final String walletId;

  const Delete(this.walletId);
}
