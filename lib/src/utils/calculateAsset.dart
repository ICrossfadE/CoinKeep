import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';

class CalculateTotal {
  double totalSum(double price, double amount) {
    return price * amount;
  }

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

  // Обчислення середньої ціни придбання
  double calculateAvarangeBuyPrice(List<TransactionEntity> assetsList) {
    // Фільтруємо  транзакції
    List<TransactionEntity> buyTransactions =
        assetsList.where((asset) => asset.type == 'BUY').toList();

    if (buyTransactions.isEmpty) {
      return 0.0;
    }

    // Обчислюємо загальну вартість і кількість придбаних активів
    double totalCost = 0;
    double totalAmount = 0;

    for (var transaction in buyTransactions) {
      totalCost +=
          transaction.price! * transaction.amount!; // Загальна сума витрат
      totalAmount += transaction.amount!; // Загальна кількість активів
    }

    return totalCost / totalAmount;
  }

  // Обчислення прибутку або збитку від поточної ціни
  double calculateProfit(
      List<TransactionEntity> transactions, double currentPrice) {
    if (transactions.isEmpty) return 0.0;
    double totalInvested = totalInvest(transactions);
    double totalCoinsValue = totalCoins(transactions);

    double totalCurrentValue = totalCoinsValue * currentPrice;

    return totalCurrentValue - totalInvested;
  }

  // Обчислення відсотку прибутку або збитку від поточної ціни
  double calculateProfitPercentage(
      List<TransactionEntity> transactions, double currentPrice) {
    if (transactions.isEmpty) return 0.0;

    double totalInvested = totalInvest(transactions);
    double totalCoinsValue = totalCoins(transactions);

    // if (totalInvested == 0.0) return 0.0;

    double totalCurrentValue = totalCoinsValue * currentPrice;

    // Обчислення відсотка прибутку
    double profitPercentage =
        ((totalCurrentValue - totalInvested) / totalInvested) * 100;

    return profitPercentage;
  }

  // Обчислення зафіксованого прибутку від продажів
  double calculateFixedProfit(List<TransactionEntity> transactions) {
    double totalProfit = 0.0;
    Map<String, List<Map<String, dynamic>>> purchasedAssets = {};

    transactions.sort((a, b) => a.date!.compareTo(b.date!));

    for (var transaction in transactions) {
      String symbol = transaction.symbol!;
      double amount = transaction.amount!.abs();
      double price = transaction.price!.abs();

      if (transaction.type == 'BUY') {
        if (!purchasedAssets.containsKey(symbol)) {
          purchasedAssets[symbol] = [];
        }
        purchasedAssets[symbol]!.add({'price': price, 'amount': amount});
      } else if (transaction.type == 'SELL') {
        if (purchasedAssets.containsKey(symbol) &&
            purchasedAssets[symbol]!.isNotEmpty) {
          double remainingSellAmount = amount;

          while (
              remainingSellAmount > 0 && purchasedAssets[symbol]!.isNotEmpty) {
            var purchase = purchasedAssets[symbol]!.first;
            double purchaseAmount = purchase['amount'];
            double purchasePrice = purchase['price'];

            if (purchaseAmount <= remainingSellAmount) {
              totalProfit += (price - purchasePrice) * purchaseAmount;
              remainingSellAmount -= purchaseAmount;
              purchasedAssets[symbol]!.removeAt(0);
            } else {
              double soldAmount = remainingSellAmount;
              totalProfit += (price - purchasePrice) * soldAmount;
              purchase['amount'] -= soldAmount;
              remainingSellAmount = 0;
            }
          }
        }
      }
    }

    return totalProfit;
  }
}
