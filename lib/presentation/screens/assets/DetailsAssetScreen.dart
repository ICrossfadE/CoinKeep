import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';

import 'package:CoinKeep/src/utils/calculateAsset.dart';

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
      backgroundColor: kDarkBg,
      appBar: AppBar(
        title: const Text(
          'Transaction Details',
          style: kAppBarStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: kDark500,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Total Coins: ${(calculateTotal.totalCoins(transactionsList)).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 30,
                    color: Colors.white,
                  ),
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
                            backgroundColor: kDark500,
                            title: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              'Are you sure you want to remove this item?',
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(true); // Підтвердити видалення
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: kCancelColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // Скасувати видалення
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: kDefaultlColor),
                                ),
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
                    name: transaction.name,
                    amount: transaction.amount,
                    price: transaction.price,
                    date: transaction.date,
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
