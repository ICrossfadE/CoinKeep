import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';

class CalculateTotal {
  // Функція для обчислення суми транзакції (ціна * кількість)
  double totalSum(double price, double amount) {
    if (price == 0.0 || amount == 0.0) {
      return 0.0;
    }
    return price * amount;
  }

  // Обчислення загальної суми інвестування
  double totalInvest(List<TransactionEntity> assetsList) {
    double invested = 0.0;

    for (var transaction in assetsList) {
      if (transaction.price != null && transaction.amount != null) {
        double transactionValue =
            transaction.price!.abs() * transaction.amount!;

        if (transaction.type == 'BUY') {
          invested += transactionValue; // Додаємо до загальних витрат
        } else if (transaction.type == 'SELL') {
          invested -= transactionValue; // Віднімаємо від витрат
        }
      }
    }

    return invested < 0.0 ? 0.0 : invested;
  }

  // Обчислення загальної кількості монет
  double totalCoins(List<TransactionEntity> assetsList) {
    double total = 0.0;

    for (var transaction in assetsList) {
      if (transaction.amount != null) {
        if (transaction.type == 'BUY') {
          total += transaction.amount!; // Додаємо до загальних витрат
        } else if (transaction.type == 'SELL') {
          total -= transaction.amount!.abs(); // Віднімаємо від витрат
        }
      }
    }

    return total < 0.0 ? 0.0 : total;
  }

  // Обчислення середньої ціни придбання
  double calculateAvarangeBuyPrice(List<TransactionEntity> transactions) {
    double totalBoughtAmount = 0.0;
    double totalCost = 0.0;

    for (var transaction in transactions) {
      if (transaction.type == 'BUY' && transaction.amount != null) {
        totalBoughtAmount += transaction.amount!;
        totalCost += (transaction.amount! *
            transaction.price!); // Для кожної покупки додаємо витрати
      }
    }

    return totalBoughtAmount == 0.0
        ? 0.0
        : totalCost / totalBoughtAmount; // Середня ціна покупки
  }

  // Обчислення прибутку від поточної ціни
  double calculateProfit(
      List<TransactionEntity> transactions, double currentPrice) {
    if (transactions.isEmpty || currentPrice <= 0) {
      return 0.0;
    }

    double totalInvested = totalInvest(transactions);
    double totalCoinsValue = totalCoins(transactions);

    if (totalCoinsValue == 0) {
      return 0.0;
    }

    double totalCurrentValue = totalCoinsValue * currentPrice;
    double profit = totalCurrentValue - totalInvested;

    return profit;
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

  // Функція для обчислення кількості залишкових монет
  double remainingCoins(List<TransactionEntity> assetsList) {
    double totalBought = 0.0;
    double totalSold = 0.0;

    for (var transaction in assetsList) {
      if (transaction.amount != null) {
        if (transaction.type == 'BUY') {
          totalBought += transaction.amount!;
        } else if (transaction.type == 'SELL') {
          totalSold += transaction.amount!.abs();
        }
      }
    }

    return totalBought - totalSold; // Це кількість залишкових монет
  }

// Функція для обчислення незафіксованого прибутку
  double calculateUnrealizedProfit(
      List<TransactionEntity> transactions, double currentPrice) {
    double remainingAmount = remainingCoins(transactions);
    double averageBuyPrice = calculateAvarangeBuyPrice(transactions);

    if (remainingAmount == 0 || averageBuyPrice == 0.0) {
      return 0.0;
    }

    double unrealizedProfit =
        (currentPrice - averageBuyPrice) * remainingAmount;

    return unrealizedProfit;
  }

// Функція для обчислення процентного незафіксованого прибутку
  double calculateUnrealizedProfitPercentage(
      List<TransactionEntity> transactions, double currentPrice) {
    double unrealizedProfit =
        calculateUnrealizedProfit(transactions, currentPrice);
    double remainingAmount = remainingCoins(transactions);
    double averageBuyPrice = calculateAvarangeBuyPrice(transactions);

    if (remainingAmount == 0 || averageBuyPrice == 0.0) {
      return 0.0;
    }

    double costOfRemainingTokens = averageBuyPrice * remainingAmount;
    double unrealizedProfitPercentage =
        (unrealizedProfit / costOfRemainingTokens) * 100;
    return unrealizedProfitPercentage;
  }
}
