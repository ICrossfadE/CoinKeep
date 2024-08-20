import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';

class CalculateAsset {
  // Обчислення загальної суми інвестування
  double totalInvest(List<TransactionsModel> assetsList) {
    double total = assetsList.fold<double>(
      0.0,
      (previousValue, transaction) {
        final double transactionValue =
            transaction.price! * transaction.amount!;
        return previousValue + transactionValue;
      },
    );

    return total;
  }

  // Обчислення загальної суми монет
  double totalCoins(List<TransactionsModel> assetsList) {
    final double total = assetsList.fold<double>(
      0.0,
      (previousValue, transaction) =>
          previousValue +
          (transaction.type == 'SELL'
              ? -transaction.amount!
              : transaction.amount!),
    );

    return total;
  }
}
