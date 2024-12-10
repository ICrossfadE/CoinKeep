part of 'get_transactions_cubit.dart';

class GetTransactionsState extends Equatable {
  final bool loading;
  final String? errorMessage;
  final List<TransactionEntity> transactions;
  final List<AssetModel> assets;
  final List<WalletEntity> currentWallets;
  final Map<String, List<AssetForWalletModel>> assetsForWallet;
  final Map<String, List<InfoForWalletModel>> infoForWallet;

  const GetTransactionsState({
    this.loading = false,
    this.errorMessage,
    this.transactions = const [],
    this.assets = const [],
    this.currentWallets = const [],
    this.assetsForWallet = const {},
    this.infoForWallet = const {},
  });

  GetTransactionsState copyWith({
    bool? loading,
    String? errorMessage,
    List<TransactionEntity>? transactions,
    List<AssetModel>? assets,
    List<WalletEntity>? currentWallets,
    Map<String, List<AssetForWalletModel>>? assetsForWallet,
    Map<String, List<InfoForWalletModel>>? infoForWallet,
  }) {
    return GetTransactionsState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
      transactions: transactions ?? this.transactions,
      assets: assets ?? this.assets,
      currentWallets: currentWallets ?? this.currentWallets,
      assetsForWallet: assetsForWallet ?? this.assetsForWallet,
      infoForWallet: infoForWallet ?? this.infoForWallet,
    );
  }

  @override
  List<Object> get props => [
        loading,
        transactions,
        assets,
        assetsForWallet,
        currentWallets,
        infoForWallet
      ];
}
