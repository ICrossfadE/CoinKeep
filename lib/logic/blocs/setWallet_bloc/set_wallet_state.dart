part of 'set_wallet_bloc.dart';

class SetWalletState extends Equatable {
  final String uid;
  final String walletName;
  final String walletColor;

  const SetWalletState({
    this.uid = '',
    this.walletName = '',
    this.walletColor = '',
  });

  SetWalletState copyWith({
    String? uid,
    String? walletName,
    String? walletColor,
  }) {
    return SetWalletState(
      uid: uid ?? this.uid,
      walletName: walletName ?? this.walletName,
      walletColor: walletColor ?? this.walletColor,
    );
  }

  @override
  List<Object> get props => [uid, walletName, walletColor];
}

final class SetWalletInitial extends SetWalletState {}
