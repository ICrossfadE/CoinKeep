import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final int? id;
  final String? coinName;
  final String? symbol;
  final double? price;

  const CardItem({
    this.id,
    this.coinName,
    this.symbol,
    this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: kDark500,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Іконка зліва
            Expanded(
              flex: 1,
              child: Hero(
                tag: 'coinLogo-$id',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: 24,
                  child: Image.network(
                    'https://s2.coinmarketcap.com/static/img/coins/64x64/$id.png',
                    width: 64,
                    height: 64,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Text(
                price != null
                    ? price!.toStringAsFixed(7)
                    : 'N/A', // Обрізка до 7 знаків після коми
                style: coinStyle,
              ),
            ),
            // Інформація про монету праворуч
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Вирівнювання до правого краю
                children: <Widget>[
                  Text("ID: $id", style: coinStyle),
                  Text(coinName ?? '', style: coinStyle),
                  Text(symbol ?? '', style: coinStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
