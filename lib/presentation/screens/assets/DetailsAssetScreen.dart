import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/src/utils/colors.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/firebase/lib/src/entities/transaction_entity.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';

import 'package:CoinKeep/src/features/calculateAsset.dart';

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
                return Dismissible(
                  key: ValueKey(transaction.id),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      context
                          .read<TransactionBloc>()
                          .add(Delete(transaction.id));
                    }
                  },
                  confirmDismiss: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      Navigator.of(context).pushNamed(
                        RouteId.editTransaction,
                        arguments: {
                          'transactionId': transaction.id,
                          'iconId': transaction.icon,
                          'nameCoin': transaction.symbol,
                          'symbol': transaction.symbol,
                          'price': transaction.price,
                          'amount': transaction.amount,
                          'type': transaction.type,
                          'wallet': transaction.wallet,
                          'date': transaction.date,
                        },
                      );
                      // Повернення `false` запобігає зникненню елемента
                      return Future.value(false);
                    } else if (direction == DismissDirection.endToStart) {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirm'),
                            content: const Text(
                              'Are you sure you want to remove this item?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(true); // Підтвердити видалення
                                },
                                child: const Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // Скасувати видалення
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return Future.value(false);
                  },
                  background: const DismisibleButton(
                    color: kEditColor,
                    aligment: Alignment.centerLeft,
                    icon: Icons.edit,
                    textButton: 'Edit',
                  ),
                  secondaryBackground: const DismisibleButton(
                    color: kCancelColor,
                    aligment: Alignment.centerRight,
                    icon: Icons.delete,
                    textButton: 'Delete',
                  ),
                  child: TransactionCard(
                    wallet: transaction.wallet,
                    type: transaction.type,
                    icon: transaction.icon,
                    symbol: transaction.symbol,
                    amount: transaction.amount,
                    price: transaction.price,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
