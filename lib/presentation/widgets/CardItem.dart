import 'package:CoinKeep/src/constants/transactionCanstants.dart';
import 'package:flutter/material.dart';

import '../../src/constants/mainConstant.dart';

class CardItem extends StatelessWidget {
  final int? id;
  final String? coinName;
  final String? symbol;

  const CardItem({
    this.id,
    this.coinName,
    this.symbol,
    super.key,
  });

  @override
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
            Hero(
              tag: 'coinLogo-$id',
              child: Image.network(
                'https://s2.coinmarketcap.com/static/img/coins/64x64/$id.png',
                width: 64,
                height: 64,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("ID: $id", style: coinStyle),
                Text("Name coin: $coinName", style: coinStyle),
                Text("$symbol", style: coinStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}