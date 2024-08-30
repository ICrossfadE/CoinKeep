import 'package:CoinKeep/src/features/calculateAsset.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String? wallet;
  final String? type;
  final String? symbol;
  final String? name;
  final int? icon;
  final double? price;
  final double? amount;
  final DateTime? date;

  const TransactionCard({
    this.wallet,
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
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: kDark500,
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
      child: Row(
        children: [
          // Left Section
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
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
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$$price",
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // CoinIcon
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 16,
                        child: Image.network(
                          'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
                          width: 32,
                          height: 32,
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
                        '\$${calcTotal.totalSum(price!, amount!)}', // Amount
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$wallet', // Pair
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
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
