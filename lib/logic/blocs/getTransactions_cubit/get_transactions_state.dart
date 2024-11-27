part of 'get_transactions_cubit.dart';

class GetTransactionsState extends Equatable {
  final List<TransactionEntity> transactions;
  final List<AssetModel> assets;
  final List<WalletEntity> currentWallets;
  final Map<String, List<AssetForWalletModel>> assetsForWallet;

  const GetTransactionsState({
    this.transactions = const [],
    this.assets = const [],
    this.currentWallets = const [],
    this.assetsForWallet = const {},
  });

  GetTransactionsState copyWith({
    List<TransactionEntity>? transactions,
    List<AssetModel>? assets,
    List<WalletEntity>? currentWallets,
    Map<String, List<AssetForWalletModel>>? assetsForWallet,
  }) {
    return GetTransactionsState(
      transactions: transactions ?? this.transactions,
      assets: assets ?? this.assets,
      currentWallets: currentWallets ?? this.currentWallets,
      assetsForWallet: assetsForWallet ?? this.assetsForWallet,
    );
  }

  @override
  List<Object> get props =>
      [transactions, assets, assetsForWallet, currentWallets];
}
