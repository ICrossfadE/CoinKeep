part of 'get_wallet_cubit.dart';

class GetWalletState extends Equatable {
  final List<WalletEntity> wallets;

  const GetWalletState({
    this.wallets = const [],
  });

  GetWalletState copyWith({
    List<WalletEntity>? wallets,
  }) {
    return GetWalletState(wallets: wallets ?? this.wallets);
  }

  @override
  List<Object> get props => [wallets];
}
