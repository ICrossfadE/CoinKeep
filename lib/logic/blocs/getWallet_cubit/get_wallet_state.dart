part of 'get_wallet_cubit.dart';

class GetWalletState extends Equatable {
  final List<WalletEntity> wallets;
  final List<WalletEntity> totalWallet;

  const GetWalletState({
    this.wallets = const [],
    this.totalWallet = const [],
  });

  GetWalletState copyWith({
    List<WalletEntity>? wallets,
    List<WalletEntity>? totalWallet,
  }) {
    return GetWalletState(
      wallets: wallets ?? this.wallets,
      totalWallet: totalWallet ?? this.totalWallet,
    );
  }

  @override
  List<Object> get props => [wallets, totalWallet];
}
