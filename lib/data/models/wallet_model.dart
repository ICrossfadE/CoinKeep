import 'package:flutter/material.dart';

class Wallet {
  String walletTitle;
  int walletProfit = 100;
  Color walletColor;

  Wallet(
      {required this.walletTitle,
      required this.walletProfit,
      required this.walletColor});
}
