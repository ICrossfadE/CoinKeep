import 'package:flutter/material.dart';

import '../../../data/utilities/constans/transactionCanstants.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: const SizedBox(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Center(
                child: Text(
                  'Transactions 0',
                  style: transactionTitle,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-transaction');
        },
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
