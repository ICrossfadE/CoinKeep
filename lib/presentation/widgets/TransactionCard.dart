import 'package:CoinKeep/src/constants/mainConstant.dart';
import 'package:flutter/material.dart';

import '../../src/constants/transactionCanstants.dart';

class TransactionCard extends StatelessWidget {
  final String? wallet;
  final String? type;
  final String? symbol;
  final int? icon;
  final double? price;
  final double? amount;
  final DateTime? date;

  const TransactionCard({
    this.wallet,
    this.type,
    this.symbol,
    this.icon,
    this.price,
    this.amount,
    this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: kCardItem,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$type",
              style: type == 'SELL' ? typeSellStyle : typeBuyStyle,
            ),
            Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
              width: 64,
              height: 64,
            ),
            Text("$wallet", style: coinStyle),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount: $amount", style: coinStyle),
                Text("Price: $price\$", style: coinStyle),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("$symbol", style: coinStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
