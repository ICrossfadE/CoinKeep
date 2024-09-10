import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';

class CalculateTotal {
  // Обчислення загальної суми інвестування
  double totalInvest(List<TransactionEntity> assetsList) {
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
  double totalCoins(List<TransactionEntity> assetsList) {
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

  double totalSum(double price, double amount) {
    return price * amount;
  }
}
