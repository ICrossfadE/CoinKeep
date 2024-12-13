import 'dart:ui';

// import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class DefaultWallet extends StatefulWidget {
  final String walletName;
  final Color walletColor;
  final double? walletInvest;
  final double? walletProfitPercent;
  final double? walletCurrentSum;
  final bool infoVisible;

  const DefaultWallet({
    required this.walletName,
    required this.walletColor,
    required this.infoVisible,
    this.walletInvest = 0.0,
    this.walletProfitPercent = 0.0,
    this.walletCurrentSum = 0.0,
    super.key,
  });

  @override
  State<DefaultWallet> createState() => _DefaultWalletState();
}

class _DefaultWalletState extends State<DefaultWallet>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    String invest = widget.walletInvest == null
        ? widget.walletInvest.toString()
        : widget.walletInvest!.toStringAsFixed(2);
    String profit = widget.walletProfitPercent == null
        ? widget.walletProfitPercent.toString()
        : widget.walletProfitPercent!.toStringAsFixed(2);
    String sum = widget.walletCurrentSum == null
        ? widget.walletCurrentSum.toString()
        : widget.walletCurrentSum!.toStringAsFixed(2);

    TextStyle setStyle(double firstInt, double secondInt) {
      if (firstInt < secondInt) {
        return kWalletInfoRed;
      } else if (firstInt > secondInt) {
        return kWalletInfoGreen;
      } else {
        return kWalletInfoGray;
      }
    }

    String setOperator(double firstInt, double secondInt, String text) {
      if (firstInt < secondInt) {
        return '-$text';
      } else if (firstInt > secondInt) {
        return '+$text';
      } else {
        return text;
      }
    }

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
                        end: Alignment.topRight,
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
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.infoVisible)
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                const Text(
                                  'Invest',
                                  style: kSmallTextP,
                                ),
                                Text(
                                  '$invest\$',
                                  style: setStyle(widget.walletInvest!, 0),
                                ),
                              ],
                            ),
                          ),
                        if (widget.infoVisible)
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                const Text(
                                  'Profit',
                                  style: kSmallTextP,
                                ),
                                Text(
                                  '${setOperator(
                                    widget.walletCurrentSum!,
                                    widget.walletInvest!,
                                    profit,
                                  )}%',
                                  style: setStyle(
                                    widget.walletCurrentSum!,
                                    widget.walletInvest!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (widget.infoVisible)
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                const Text(
                                  'Current Sum',
                                  style: kSmallTextP,
                                ),
                                Text(
                                  '$sum\$',
                                  style: setStyle(
                                    widget.walletCurrentSum!,
                                    widget.walletInvest!,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    )
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
