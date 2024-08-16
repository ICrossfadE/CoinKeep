import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/models/asset_model.dart';
import 'package:bloc/bloc.dart';

import '../../../firebase/lib/src/models/transaction_model.dart';
import 'get_transactions_cubit.dart';

class AssetCubit extends Cubit<TransactionState> {
  final GetTransactionsCubit _transactionsCubit;

  late final StreamSubscription _transactionSubscription;

  AssetCubit(this._transactionsCubit) : super(_transactionsCubit.state) {
    _transactionSubscription = _transactionsCubit.stream.listen((state) {
      final assets = _createAssets(state.transactions);
      emit(state.copyWith(assets: assets));
    });
  }

  List<AssetModel> _createAssets(List<TransactionsModel> transaction) {
    // Логіка групування транзакцій в актив
    List<AssetModel> items = [];

    for (TransactionsModel transactionValue in transaction) {
      AssetModel newItem = AssetModel(
        symbol: transactionValue.symbol,
        wallet: transactionValue.wallet,
        icon: transactionValue.icon,
        transactions: transactions,
      );
    }

    return [];
  }

  @override
  Future<void> close() {
    _transactionSubscription.cancel();
    return super.close();
  }
}
