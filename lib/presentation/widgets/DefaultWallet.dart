import 'dart:ui';

// import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';

class DefaultWallet extends StatefulWidget {
  final String walletName;
  final double walletHeight;
  final Color walletColor;
  final TextStyle walletStyle;
  final double? walletInvest;
  final double? walletProfitPercent;
  final double? walletCurretProfitSum;
  final double? walletCurrentSum;
  final bool infoVisible;

  const DefaultWallet({
    required this.walletName,
    required this.walletHeight,
    required this.walletColor,
    required this.walletStyle,
    required this.infoVisible,
    this.walletInvest = 0.0,
    this.walletProfitPercent = 0.0,
    this.walletCurretProfitSum = 0.0,
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
    String profitSum = widget.walletCurretProfitSum == null
        ? widget.walletCurretProfitSum.toString()
        : widget.walletCurretProfitSum!.toStringAsFixed(2);
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
        height: widget.walletHeight,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: const Alignment(2.8, -2.5),
                colors: [kDarkBg, widget.walletColor]),
            border: Border.all(
              width: 2,
              color: widget.walletColor,
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.walletName,
                      style: widget.walletStyle,
                    ),
                    if (widget.infoVisible)
                      Text(
                        '$invest\$',
                        style: kLargeTextP,
                      ),
                    if (widget.infoVisible) const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.infoVisible)
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                const Text(
                                  'Profit Sum',
                                  style: kTextP,
                                ),
                                Text(
                                  widget.walletCurretProfitSum! > 0
                                      ? '+$profitSum\$'
                                      : '$profitSum\$',
                                  style: setStyle(
                                      widget.walletCurretProfitSum!, 0),
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
                                  style: kTextP,
                                ),
                                Text(
                                  widget.walletProfitPercent! > 0
                                      ? '+$profit%'
                                      : '$profit%',
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
                                  style: kTextP,
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
