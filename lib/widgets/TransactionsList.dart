import 'package:CoinKeep/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          //fetchUsers
          print('create Transactions'),
        },
        child: const Icon(Icons.get_app),
      ),
    );
  }
}










// floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print('Add new Transactions');
//         },
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         child: const Icon(
//           CupertinoIcons.add,
//           color: Colors.white,
//         ),
//       ),