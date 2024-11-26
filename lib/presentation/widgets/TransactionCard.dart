import 'package:CoinKeep/src/utils/calculateAsset.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String? wallet;
  final Color? walletColor;
  final String? type;
  final String? symbol;
  final String? name;
  final int? icon;
  final double? price;
  final double? amount;
  final DateTime? date;

  const TransactionCard({
    this.wallet,
    this.walletColor,
    this.type,
    this.symbol,
    this.name,
    this.icon,
    this.price,
    this.amount,
    this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CalculateTotal calcTotal = CalculateTotal();
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(date!); // Форматування дати

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: kDark500,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // зсув тіні по осі X і Y
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Left Section
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 4, 1, 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: type == 'SELL' ? kBuyStyle : kSellStyle,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$type",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${price?.abs().toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white54,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "$symbol $amount",
                    style: const TextStyle(
                      color: Colors.white54,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Section
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // CoinIcon
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 12,
                        child: Image.network(
                          'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$symbol', // Pair
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            '$name', // Pair
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${calcTotal.totalSum(price!, amount!).abs().toStringAsFixed(2)}', // Amount
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 6),
                        decoration: BoxDecoration(
                          color: walletColor?.withAlpha(160),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          wallet!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Text(
                        formattedDate, // Pair
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
