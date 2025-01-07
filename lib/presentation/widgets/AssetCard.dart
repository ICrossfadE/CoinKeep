import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String? wallet;
  final String? name;
  final double? coinPrice;
  final double? currentPrice;
  final double? totalCoins;
  final double? profitPercent;
  final double? profit;
  final int? icon;
  final List<TransactionEntity>? transaction;

  const AssetCard({
    this.wallet,
    this.name,
    this.coinPrice,
    this.currentPrice,
    this.totalCoins,
    this.profitPercent,
    this.profit,
    this.icon,
    this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget getIcon() {
      if (icon != null) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          maxRadius: 24,
          child: ClipOval(
            child: Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/$icon.png',
              width: 64,
              height: 64,
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
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
                      getIcon(),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$name',
                            style: kTextP.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(130),
                            ),
                          ),
                          Text(
                            coinPrice! > 1
                                ? '${coinPrice!.toStringAsFixed(2)}\$'
                                : '${coinPrice!.toStringAsFixed(7)}\$',
                            style: kSmallText,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Right Section
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: profitPercent! == 0
                      ? kZeroStyle
                      : (profitPercent! < 0 ? kBuyStyle : kSellStyle),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${profitPercent!.abs().toStringAsFixed(2)}%",
                    style: kMediumText.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profitPercent! == 0.00
                        ? "${profit?.toStringAsFixed(2)}\$"
                        : profit! == profit!.abs()
                            ? "+${profit?.toStringAsFixed(2)}\$"
                            : "${profit?.toStringAsFixed(2)}\$",
                    style: kSmallText.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
