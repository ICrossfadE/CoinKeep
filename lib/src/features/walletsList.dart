import 'package:flutter/cupertino.dart';

import 'package:CoinKeep/firebase/lib/src/models/wallet_model.dart';

class WalletsList {
  // ignore: unused_field
  int _focusedIndex = 0;

  final List<Wallet> _walletData = [
    // Wallet(
    //   walletTitle: 'Total Balance',
    //   walletProfit: 100,
    //   walletColor: const Color(0xFF51C786),
    // ),
    Wallet(
      walletTitle: 'Binance',
      walletProfit: 80,
      walletColor: const Color(0xFFF0B800),
    ),
    Wallet(
      walletTitle: 'MetaMask',
      walletProfit: 60,
      walletColor: const Color(0xFFF3872F),
    ),
    Wallet(
      walletTitle: 'OKX',
      walletProfit: 44,
      walletColor: const Color(0xFF807D7D),
    ),
    Wallet(
      walletTitle: 'Keplr',
      walletProfit: 10,
      walletColor: const Color(0xFF5491EC),
    ),
  ];

  List<Wallet> getAllWallets() {
    return _walletData;
  }

  String getWalletsTitle(int index) {
    return _walletData[index].walletTitle;
  }

  String getWalletsPercent(int index) {
    return _walletData[index].walletProfit.toString();
  }

  Color getWalletColor(int index) {
    return _walletData[index].walletColor;
  }

  int getWalletsLength() {
    return _walletData.length;
  }

  int updateFocusedIndex(int index) {
    return _focusedIndex = index;
  }
}
