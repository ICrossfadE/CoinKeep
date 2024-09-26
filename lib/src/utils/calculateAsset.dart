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

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // Обчислення зафіксованого прибутку від продажів
  double calculateRealizedProfit(List<TransactionEntity> transactions) {
    if (transactions.isEmpty) return 0.0;

    double totalRealizedProfit = 0.0;

    // Зберігаємо кількість активів, які залишилися у вас
    Map<String, double> remainingAssets = {};

    for (var transaction in transactions) {
      if (transaction.type == 'BUY') {
        // Додаємо до залишків активів
        remainingAssets[transaction.symbol!] =
            (remainingAssets[transaction.symbol] ?? 0.0) + transaction.amount!;
      } else if (transaction.type == 'SELL') {
        // Перевіряємо, скільки активів ми маємо
        double availableAmount = remainingAssets[transaction.symbol] ?? 0.0;

        if (availableAmount >= transaction.amount!) {
          // Обчислюємо прибуток для продажу
          double profit =
              (calculateAvarangeBuyPrice(transactions) - transaction.price!) *
                  transaction.amount!;
          totalRealizedProfit += profit;

          // Зменшуємо залишки активів
          remainingAssets[transaction.symbol!] =
              transaction.amount! - availableAmount;
        }
      }
    }

    return totalRealizedProfit;
  }
}
