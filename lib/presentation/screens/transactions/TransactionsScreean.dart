import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';
import 'package:CoinKeep/src/constants/mainConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import '../../routes/routes.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<GetTransactionsCubit, TransactionState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total transactions: ${state.transactions.length}'),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<GetTransactionsCubit, TransactionState>(
              builder: (context, state) {
                if (state.transactions.isEmpty) {
                  return const Center(child: Text('No transactions found.'));
                }
                return ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
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
        backgroundColor: kConfirmButtons,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
