import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../src/constants/transactionCanstants.dart';

class AssetCard extends StatelessWidget {
  final String? wallet;
  final String? symbol;
  final int? icon;
  final List<TransactionsModel>? transaction;

  const AssetCard({
    this.wallet,
    this.symbol,
    this.icon,
    this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
              width: 64,
              height: 64,
            ),
            Text("$wallet", style: coinStyle),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("Symbol: $symbol", style: coinStyle),
              ],
            ),
            Text("Trans ${transaction?.length}", style: coinStyle),
          ],
        ),
      ),
    );
  }
}
