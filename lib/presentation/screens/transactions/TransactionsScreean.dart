import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../src/constants/transactionCanstants.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

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
          Navigator.of(context).pushNamed(RouteId.addTransaction);
        },
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
