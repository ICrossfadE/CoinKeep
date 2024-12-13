import 'package:flutter/material.dart';

class TotalWallet extends StatefulWidget {
  final String walletName;
  final Color walletColor;
  final String? walletInvest;
  final String? walletProfitPercent;
  final String? walletCurrentSum;

  const TotalWallet({
    required this.walletName,
    required this.walletColor,
    this.walletInvest = '0.00',
    this.walletProfitPercent = '0.00',
    this.walletCurrentSum = '0.00',
    super.key,
  });

  @override
  State<TotalWallet> createState() => _TotalWalletState();
}

class _TotalWalletState extends State<TotalWallet>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
