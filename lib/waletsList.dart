import 'data/models/wallet_model.dart';

class WaletsList {
  int _focusedIndex = 0;

  final List<Wallet> _waletData = [
    Wallet(walletTitle: 'Total Balance', waletProfit: 100),
    Wallet(walletTitle: 'Binance', waletProfit: 80),
    Wallet(walletTitle: 'MetaMask', waletProfit: 60),
    Wallet(walletTitle: 'OKX', waletProfit: 44),
    Wallet(walletTitle: 'Keplr', waletProfit: 10),
  ];

  String getWalletsTitle() {
    return _waletData[_focusedIndex].walletTitle;
  }

  String getWalletsPercent() {
    return _waletData[_focusedIndex].waletProfit.toString();
  }

  int getWalletsLength() {
    return _waletData.length;
  }

  int getFocusedIndex(index) {
    return _focusedIndex = index;
  }
}
