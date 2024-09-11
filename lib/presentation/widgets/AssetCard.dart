import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String? wallet;
  final String? name;
  final double? totalSum;
  final int? icon;
  final List<TransactionEntity>? transaction;

  const AssetCard({
    this.wallet,
    this.name,
    this.totalSum,
    this.icon,
    this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // CoinIcon
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 24,
                        child: Image.network(
                          'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
                          width: 64,
                          height: 64,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$name', // Pair
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  // const Row(
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text(
                  //           'Price', // Pair
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 10.0,
                  //           ),
                  //         ),
                  //         Text(
                  //           '10000', // Pair
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 14.0,
                  //           ),
                  //         ),
                  //         Text(
                  //           'Percent', // Pair
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 10.0,
                  //           ),
                  //         ),
                  //         Text(
                  //           '20000', // Paira
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 14.0,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text(
                  //           'Price', // Pair
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 10.0,
                  //           ),
                  //         ),
                  //         Text(
                  //           '30000', // Pair
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 14.0,
                  //           ),
                  //         ),
                  //         Text(
                  //           'Percent', // Pair
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 10.0,
                  //           ),
                  //         ),
                  //         Text(
                  //           '40000', // Paira
                  //           style: TextStyle(
                  //             color: Colors.white70,
                  //             fontSize: 14.0,
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          // Right Section
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: 1 < 0 ? kBuyStyle : kSellStyle,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "100%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  Text(
                    "\$${totalSum}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   margin: const EdgeInsets.symmetric(vertical: 5),
    //   decoration: BoxDecoration(
    //     color: kCardColor,
    //     // borderRadius: BorderRadius.circular(8),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.2),
    //         spreadRadius: 2,
    //         blurRadius: 6,
    //         offset: const Offset(0, 3), // зсув тіні по осі X і Y
    //       ),
    //     ],
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Image.network(
    //           'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
    //           width: 64,
    //           height: 64,
    //         ),
    //         Text("$wallet", style: coinStyle),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           children: <Widget>[
    //             Text("$symbol", style: coinStyle),
    //           ],
    //         ),
    //         Text("Trans ${transaction?.length}", style: coinStyle),
    //       ],
    //     ),
    //   ),
    // );
  }
}
