import 'package:CoinKeep/firebase/lib/src/models/transaction.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import '../../routes/routes.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<GetTransactionsCubit, List<TransactionsModel>>(
            builder: (context, transactions) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total transactions: ${transactions.length}'),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<GetTransactionsCubit, List<TransactionsModel>>(
              builder: (context, transactions) {
                if (transactions.isEmpty) {
                  return const Center(child: Text('No transactions found.'));
                }
                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return TransactionCard(
                      wallet: transaction.wallet,
                      type: transaction.type,
                      icon: transaction.icon,
                      symbol: transaction.symbol,
                      amount: transaction.amount,
                      price: transaction.price,
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
          Navigator.of(context).pushNamed(RouteId.addTransaction);
        },
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
