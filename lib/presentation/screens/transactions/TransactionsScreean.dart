// import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';

import '../../../logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import '../../routes/routes.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBg,
      body: Column(
        children: [
          BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total transactions: ${state.transactions.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
              builder: (context, state) {
                if (state.transactions.isEmpty) {
                  return const Center(child: Text('No transactions found.'));
                }
                return ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
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
                        name: transaction.name,
                        amount: transaction.amount,
                        price: transaction.price,
                        date: transaction.date,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteId.searchCoins);
        },
        backgroundColor: kConfirmColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
