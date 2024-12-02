part of 'get_wallet_cubit.dart';

class GetWalletState extends Equatable {
  final List<WalletEntity> wallets;
  final List<WalletEntity> filteredWallets;

  const GetWalletState({
    this.wallets = const [],
    this.filteredWallets = const [],
  });

  GetWalletState copyWith({
    List<WalletEntity>? wallets,
    List<WalletEntity>? filteredWallets,
  }) {
    return GetWalletState(
      wallets: wallets ?? this.wallets,
      filteredWallets: filteredWallets ?? this.filteredWallets,
    );
  }

  @override
  List<Object> get props => [wallets, filteredWallets];
}
