import 'package:CoinKeep/src/utils/colors.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:flutter/material.dart';

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
            Text(
              "$type",
              style: type == 'SELL' ? typeSellStyle : typeBuyStyle,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount: $amount", style: coinStyle),
                Text("Price: $price\$", style: coinStyle),
              ],
            ),
            Text("$wallet", style: coinStyle),
            Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
              width: 64,
              height: 64,
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
