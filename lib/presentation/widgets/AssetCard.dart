import 'package:CoinKeep/firebase/lib/src/entities/transaction_entity.dart';
import 'package:flutter/material.dart';

import '../../src/constants/mainConstant.dart';
import '../../src/constants/transactionCanstants.dart';

class AssetCard extends StatelessWidget {
  final String? wallet;
  final String? symbol;
  final int? icon;
  final List<TransactionEntity>? transaction;

  const AssetCard({
    this.wallet,
    this.symbol,
    this.icon,
    this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: kCardColor,
        // borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // зсув тіні по осі X і Y
          ),
        ],
      ),
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
                Text("$symbol", style: coinStyle),
              ],
            ),
            Text("Trans ${transaction?.length}", style: coinStyle),
          ],
        ),
      ),
    );
  }
}
