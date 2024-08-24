import 'package:CoinKeep/firebase/lib/src/entities/transaction_entity.dart';
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
    final List<TransactionEntity> transactionsList =
        arguments?['transactionList'] ?? [];
    final CalculateTotal calculateTotal = CalculateTotal();

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
