import 'package:CoinKeep/src/utils/colors.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:flutter/material.dart';

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
