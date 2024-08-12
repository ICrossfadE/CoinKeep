import 'package:CoinKeep/firebase/lib/src/models/transaction.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: BlocBuilder<GetTransactionsCubit, List<TransactionsModel>>(
        builder: (context, transactions) {
          if (transactions.isEmpty) {
            return Center(child: Text('No transactions found.'));
          }
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(transaction.symbol!),
                subtitle: Text('Amount: ${transaction.amount}'),
              );
            },
          );
        },
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


// return Scaffold(
//       body: const SizedBox(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(14.0),
//               child: Center(
//                 child: Text(
//                   'Transactions 0',
//                   style: transactionTitle,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       