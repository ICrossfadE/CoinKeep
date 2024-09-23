import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:bloc/bloc.dart';

import 'package:CoinKeep/firebase/lib/src/models/asset_model.dart';

import 'get_transactions_cubit.dart';

class AssetCubit extends Cubit<GetTransactionsState> {
  final GetTransactionsCubit _transactionsCubit;
  late final StreamSubscription _transactionSubscription;

  AssetCubit(this._transactionsCubit)
      : super(const GetTransactionsState(transactions: [], assets: [])) {
    _transactionSubscription = _transactionsCubit.stream.listen((state) {
      final assets = _createAssets(state.transactions);
      emit(state.copyWith(assets: assets));
    });

    // Ініціалізація з поточним станом транзакцій при необхідності
    final initialAssets = _createAssets(_transactionsCubit.state.transactions);
    emit(state.copyWith(assets: initialAssets));
  }

  List<AssetModel> _createAssets(List<TransactionEntity> transactions) {
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
    groupedTransactions.forEach((symbol, transactionList) {
      if (transactionList.isNotEmpty) {
        double totalValue = transactionList.fold(0.0, (sum, transaction) {
          return sum + (transaction.price! * transaction.amount!);
        });

        items.add(
          AssetModel(
            name: transactionList.first.name,
            wallet: transactionList.first.walletId,
            totalSum: totalValue,
            icon: transactionList.first.icon,
            transactions: transactionList,
          ),
        );
      }
    });
    return items;
  }

  @override
  Future<void> close() async {
    await _transactionSubscription.cancel();
    return super.close();
  }
}
