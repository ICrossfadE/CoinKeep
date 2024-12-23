import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
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
    Widget getIcon() {
      if (id != null) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24,
          child: ClipOval(
            child: Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/$id.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover, // Забезпечує повне заповнення області
            ),
          ),
        );
      } else {
        return const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24,
          child: ClipOval(
            child: Image(
              image: AssetImage('assets/dollar.png'),
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 9),
      decoration: BoxDecoration(
        color: kDark500,
        borderRadius: BorderRadius.circular(10),
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
                  radius: 24,
                  child: getIcon(),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Text(
                price! > 1
                    ? price!.toStringAsFixed(2)
                    : price != null
                        ? price!.toStringAsFixed(7)
                        : 'N/A',
                style: kSmallText,
              ),
            ),
            // Інформація про монету праворуч
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Вирівнювання до правого краю
                children: <Widget>[
                  Text("ID: $id", style: kTextP),
                  Text(coinName ?? '', style: kTextP),
                  Text(symbol ?? '', style: kTextP),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
