import 'package:flutter/cupertino.dart';

import '../../../data/models/wallet_model.dart';

class WalletsList {
  int _focusedIndex = 0;

  final List<Wallet> _walletData = [
    Wallet(
      walletTitle: 'Total Balance',
      waletProfit: 100,
      waletColor: const Color(0xFF51C786),
    ),
    Wallet(
      walletTitle: 'Binance',
      waletProfit: 80,
      waletColor: const Color(0xFFDDDA34),
    ),
    Wallet(
      walletTitle: 'MetaMask',
      waletProfit: 60,
      waletColor: const Color(0xFFF3872F),
    ),
    Wallet(
      walletTitle: 'OKX',
      waletProfit: 44,
      waletColor: const Color(0xE8807D7D),
    ),
    Wallet(
      walletTitle: 'Keplr',
      waletProfit: 10,
      waletColor: const Color(0xE85491EC),
    ),
  ];

  String getWalletsTitle(int index) {
    return _walletData[index].walletTitle;
  }

  String getWalletsPercent(int index) {
    return _walletData[index].waletProfit.toString();
  }

  Color getWalletColor(int index) {
    return _walletData[index].waletColor;
  }

  int getWalletsLength() {
    return _walletData.length;
  }

  int updateFocusedIndex(int index) {
    return _focusedIndex = index;
  }
}
