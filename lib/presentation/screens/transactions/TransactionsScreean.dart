import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';
import 'package:CoinKeep/src/constants/mainConstant.dart';

import '../../../logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import '../../routes/routes.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total transactions: ${state.transactions.length}'),
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
                        if (direction == DismissDirection.startToEnd) {
                          print('Edit');
                        } else if (direction == DismissDirection.endToStart) {
                          print('delete');
                          context
                              .read<TransactionBloc>()
                              .add(Delete((transaction.id).toString()));
                        }
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
        backgroundColor: kConfirmColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
