import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/assetForWallet_model.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/src/utils/calculateAsset.dart';
import 'package:bloc/bloc.dart';

import 'package:CoinKeep/firebase/lib/src/models/asset_model.dart';

import 'get_transactions_cubit.dart';

class AssetCubit extends Cubit<GetTransactionsState> {
  final GetTransactionsCubit _transactionsCubit;
  final GetWalletCubit _walletCubit;
  final LocalCacheBloc _localCacheBloc;
  final SetWalletBloc _setWalletBloc;

  late final StreamSubscription _transactionSubscription;
  late final StreamSubscription _localCacheSubscription;
  late final StreamSubscription _walletSubscription;

  AssetCubit(
    this._transactionsCubit,
    this._localCacheBloc,
    this._walletCubit,
    this._setWalletBloc,
  ) : super(const GetTransactionsState(
          transactions: [],
          assetsForWallet: {},
          currentWallets: [],
          assets: [],
        )) {
    // Ініціалізація з поточним станом транзакцій при необхідності
    _updateState(
      state.transactions,
      _localCacheBloc.state,
      _walletCubit.state.wallets,
    );

    // Підписка на зміни стану кешу
    _localCacheSubscription = _localCacheBloc.stream.listen((state) {
      final assets =
          _createAssets(_transactionsCubit.state.transactions, state);
      final assetsForWallet = _createAssetsForWallet(
        _transactionsCubit.state.transactions,
        state,
        _walletCubit.state.wallets,
      );
      emit(GetTransactionsState(
        transactions: _transactionsCubit.state.transactions,
        assetsForWallet: assetsForWallet,
        assets: assets,
      ));
    });

    // Підписка на транзакції
    _transactionSubscription = _transactionsCubit.stream.listen((state) {
      _updateState(
        state.transactions,
        _localCacheBloc.state,
        _walletCubit.state.wallets,
      );
    });

    // // Підписка на гаманці
    _walletSubscription = _walletCubit.stream.listen((state) {
      _updateState(
        _transactionsCubit.state.transactions,
        _localCacheBloc.state,
        _walletCubit.state.wallets,
      );
      // emit(GetTransactionsState(currentWallets: _walletCubit.state.wallets));
    });
  }

  void _updateState(List<TransactionEntity> transactions,
      LocalCacheState cacheState, List<WalletEntity> walletsState) {
    final assets = _createAssets(transactions, cacheState);
    final assetsForWallet =
        _createAssetsForWallet(transactions, cacheState, walletsState);

    emit(state.copyWith(
      assets: assets,
      currentWallets: walletsState,
      assetsForWallet: assetsForWallet,
    ));
  }

  List<AssetModel> _createAssets(
      List<TransactionEntity> transactions, LocalCacheState cacheState) {
    // Мапа для групування транзакцій за символом монети
    Map<String, List<TransactionEntity>> groupedTransactions = {};

    // Групуємо транзакції за символом монети
    for (TransactionEntity transaction in transactions) {
      if (transaction.symbol != null) {
        if (groupedTransactions.containsKey(transaction.symbol)) {
          groupedTransactions[transaction.symbol]!.add(transaction);
        } else {
          groupedTransactions[transaction.symbol!] = [transaction];
        }
      }
    }

    // Створюємо список AssetModel з мапи
    List<AssetModel> items = [];

    groupedTransactions.forEach(
      (symbol, transactionList) {
        if (transactionList.isNotEmpty) {
          // Отримання поточної ціни з LocalCacheState
          final currentPrice = cacheState.coinModel?.data
                  ?.firstWhere((coin) => coin.symbol == symbol)
                  .quote
                  ?.uSD
                  ?.price ??
              0.0;
          double totalValue = CalculateTotal().totalInvest(transactionList);
          double totalCoinsValue = CalculateTotal().totalCoins(transactionList);
          double realizedProfitValue =
              CalculateTotal().calculateFixedProfit(transactionList);
          double profitPercentageValue = CalculateTotal()
              .calculateUnrealizedProfitPercentage(
                  transactionList, currentPrice);
          double profitValue =
              CalculateTotal().calculateProfit(transactionList, currentPrice);
          double averagePriceValue =
              CalculateTotal().calculateAvarangeBuyPrice(transactionList);

          // Сортуємо транзакції за датою в порядку зростання
          transactionList.sort((b, a) => a.date!.compareTo(b.date!));

          items.add(
            AssetModel(
              name: transactionList.first.name,
              wallet: transactionList.first.walletId,
              totalInvest: totalCoinsValue == 0 ? 0.00 : totalValue,
              totalCoins: totalCoinsValue,
              averagePrice: averagePriceValue,
              currentPrice: totalCoinsValue * currentPrice,
              profitPercent:
                  totalCoinsValue == 0 ? 0.00 : profitPercentageValue,
              fixedProfit: realizedProfitValue,
              profit: profitValue,
              symbol: transactionList.first.symbol,
              icon: transactionList.first.icon,
            ),
          );
        }
      },
    );

    items.sort((a, b) {
      if (a.profitPercent! > 0 && b.profitPercent! > 0) {
        // Обидва прибуткові, сортуємо за спаданням
        return b.profitPercent!.compareTo(a.profitPercent!);
      } else if (a.profitPercent! < 0 && b.profitPercent! < 0) {
        // Обидва збиткові, сортуємо за зростанням
        return a.profitPercent!.compareTo(b.profitPercent!);
      } else if (a.profitPercent! > 0 && b.profitPercent! <= 0) {
        // Прибуткові мають бути першими
        return -1;
      } else if (a.profitPercent! <= 0 && b.profitPercent! > 0) {
        // Збиткові після прибуткових
        return 1;
      } else if (a.profitPercent == 0 && b.profitPercent != 0) {
        // 0% мають бути в кінці
        return 1;
      } else if (a.profitPercent != 0 && b.profitPercent == 0) {
        return -1;
      }
      return 0;
    });

    return items;
  }

  Map<String, List<AssetForWalletModel>> _createAssetsForWallet(
    List<TransactionEntity> transactions,
    LocalCacheState cacheState,
    List<WalletEntity> walletsState,
  ) {
    final groupedTransactions = <String, List<TransactionEntity>>{};

    // Загальна івестиція всіх транзакцій
    final double mainTotalWalletInvest =
        CalculateTotal().totalInvest(transactions);

    //Групування транзакцій за символом
    for (var trx in transactions) {
      if (trx.symbol != null) {
        if (groupedTransactions.containsKey(trx.symbol!)) {
          groupedTransactions[trx.symbol!]!.add(trx);
        } else {
          groupedTransactions[trx.symbol!] = [trx];
        }
      }
    }

    // Розрахунок інвестиції з урахуванням поточної ціни
    double currentTotalSum = 0.0;

    groupedTransactions.forEach((symbol, itemList) {
      final currentPrice = cacheState.coinModel?.data
              ?.firstWhere((coin) => coin.symbol == symbol)
              .quote
              ?.uSD
              ?.price ??
          0.0;

      currentTotalSum +=
          CalculateTotal().totalCurrentProfit(itemList, currentPrice);
    });

    // Розрахунок загальної відсоткової різниці гаманця
    double currentTotalProfitPercentage = CalculateTotal()
        .calculateTotalProfitPercentage(mainTotalWalletInvest, currentTotalSum);

    //Групування активів за гаманцем
    final groupedAssets = <String, List<AssetForWalletModel>>{};

    for (var wallet in walletsState) {
      final assetList = <AssetForWalletModel>[];
      final assetListForTotal = <AssetForWalletModel>[];

      groupedTransactions.forEach((symbol, transactionList) {
        // Загальна івестиція транзакцій гоманця
        final double currentWalletInvest =
            CalculateTotal().totalInvest(transactionList);
        // Отримати транзакції для поточного гаманця
        final walletTransactions = transactionList
            .where((trx) => trx.walletId == wallet.walletId)
            .toList();

        // Обчислити математику для поточного символу і гаманця
        if (walletTransactions.isNotEmpty) {
          final currentPrice = cacheState.coinModel?.data
                  ?.firstWhere((coin) => coin.symbol == symbol)
                  .quote
                  ?.uSD
                  ?.price ??
              0.0;

          // Розрахунок інвестиції з урахуванням поточної ціни
          double currentWalletSum = 0.0;

          currentWalletSum += CalculateTotal()
              .totalCurrentProfit(walletTransactions, currentPrice);

          // Розрахунок загальної відсоткової різниці гаманця
          double currentWalletProfitPercentage = CalculateTotal()
              .calculateTotalProfitPercentage(
                  currentWalletInvest, currentWalletSum);

          // Розрахунок всіх монет гаманця
          double totalCoinsValue =
              CalculateTotal().totalCoins(walletTransactions);
          // Розрахунок відсотку для кожного ассета
          double profitPercentageValue = CalculateTotal()
              .calculateUnrealizedProfitPercentage(
                  walletTransactions, currentPrice);

          // Ассет для кожного гаманця
          assetList.add(
            AssetForWalletModel(
              walletId: wallet.walletId!,
              symbol: symbol,
              icon: walletTransactions.first.icon,
              totalInvest: currentWalletInvest,
              totalCurentSum:
                  currentWalletSum == 0.00 ? 0.00 : currentWalletSum,
              currentTotalProfitPercent: currentWalletProfitPercentage == 0.00
                  ? 0.00
                  : currentWalletProfitPercentage,
              profitPercent:
                  totalCoinsValue == 0 ? 0.00 : profitPercentageValue,
            ),
          );
        }

        // Формуєм Assets для гаманця Total
        final currentPrice = cacheState.coinModel?.data
                ?.firstWhere((coin) => coin.symbol == symbol)
                .quote
                ?.uSD
                ?.price ??
            0.0;
        double totalCoinsValue = CalculateTotal().totalCoins(transactionList);
        double profitPercentageValue = CalculateTotal()
            .calculateUnrealizedProfitPercentage(transactionList, currentPrice);

        assetListForTotal.add(
          AssetForWalletModel(
            walletId: wallet.walletId!,
            symbol: symbol,
            icon: transactionList.first.icon,
            totalInvest:
                mainTotalWalletInvest == 0.00 ? 0.00 : mainTotalWalletInvest,
            totalCurentSum: currentTotalSum == 0.00 ? 0.00 : currentTotalSum,
            profitPercent: totalCoinsValue == 0 ? 0.00 : profitPercentageValue,
            currentTotalProfitPercent: currentTotalProfitPercentage == 0
                ? 0.00
                : currentTotalProfitPercentage,
          ),
        );
      });

      groupedAssets[wallet.walletId!] = assetList;
      groupedAssets[_setWalletBloc.state.totalUuid] = assetListForTotal;
    }

    return groupedAssets;
  }

  @override
  Future<void> close() async {
    await _transactionSubscription.cancel();
    await _localCacheSubscription.cancel();
    await _walletSubscription.cancel();
    return super.close();
  }
}
