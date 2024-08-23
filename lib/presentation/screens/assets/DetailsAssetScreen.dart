import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';
import 'package:CoinKeep/src/constants/mainConstant.dart';
import 'package:CoinKeep/src/utils/calculateAsset.dart';
import 'package:flutter/material.dart';

class DetailsAssetScreen extends StatelessWidget {
  const DetailsAssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final List<TransactionsModel> transactionsList =
        arguments?['transactionList'] ?? [];
    final CalculateTotal calculateTotal = CalculateTotal();

    // Обчислення загальної суми інвестування
    // final double totalInvest = transactionsList.fold<double>(
    //   0.0,
    //   (previousValue, transaction) {
    //     final double transactionValue =
    //         transaction.price! * transaction.amount!;
    //     return previousValue + transactionValue;
    //   },
    // );

    // Обчислення загальної суми монет
    // final double totalCoins = transactionsList.fold<double>(
    //   0.0,
    //   (previousValue, transaction) =>
    //       previousValue +
    //       (transaction.type == 'SELL'
    //           ? -transaction.amount!
    //           : transaction.amount!),
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // 'Total Invest: ${totalInvest.toStringAsFixed(2)}\$',
                  'Total Invest: ${(calculateTotal.totalInvest(transactionsList)).toStringAsFixed(2)}\$',
                  style: kTextLarge,
                ),
                Text(
                  'Total Coins: ${(calculateTotal.totalCoins(transactionsList)).toStringAsFixed(2)}',
                  style: kTextLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactionsList.length,
              itemBuilder: (context, index) {
                final transaction = transactionsList[index];
                return TransactionCard(
                  wallet: transaction.wallet,
                  type: transaction.type,
                  icon: transaction.icon,
                  symbol: transaction.symbol,
                  amount: transaction.amount,
                  price: transaction.price,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
