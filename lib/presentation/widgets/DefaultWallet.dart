import 'dart:ui';

import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class DefaultWallet extends StatefulWidget {
  final String walletName;
  final Color walletColor;
  final String? walletInvest;
  final String? walletProfitPercent;
  final String? walletCurrentSum;
  final bool infoVisible;

  const DefaultWallet({
    required this.walletName,
    required this.walletColor,
    required this.infoVisible,
    this.walletInvest,
    this.walletProfitPercent,
    this.walletCurrentSum,
    super.key,
  });

  @override
  State<DefaultWallet> createState() => _DefaultWalletState();
}

class _DefaultWalletState extends State<DefaultWallet>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 22, 22),
            border: Border.all(
              width: 2,
              color: widget.walletColor,
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -1),
                child: Container(
                  height: 350,
                  width: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: widget.walletColor,
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.transparent, widget.walletColor]),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // widget.wallets[index].walletName,
                      widget.walletName,
                      style: kLargeText,
                    ),
                    if (widget.infoVisible)
                      Text(
                        widget.walletInvest ?? '0.00',
                        // item?.totalWalletInvest == null
                        //     ? 'invest: 0.00 \$'
                        //     : 'invest: ${item?.totalWalletInvest.toStringAsFixed(2)} \$',
                        style: styleWalletProfit,
                      ),
                    if (widget.infoVisible)
                      Text(
                        widget.walletProfitPercent ?? '0.00',
                        // item?.currentTotalProfitPercent == null
                        //     ? 'percent: 0.00 %'
                        //     : 'percent: ${item?.currentTotalProfitPercent.toStringAsFixed(2)} %',
                        style: styleWalletProfit,
                      ),
                    if (widget.infoVisible)
                      Text(
                        widget.walletCurrentSum ?? '0.00',
                        // item?.totalCurentSum == null
                        //     ? 'profit: 0.00 \$'
                        //     : 'profit: ${item?.totalCurentSum.toStringAsFixed(2)} \$',
                        style: styleWalletProfit,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
