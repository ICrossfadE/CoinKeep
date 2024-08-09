import 'package:flutter/material.dart';

import 'package:CoinKeep/src/constants/transactionCanstants.dart';
import 'package:CoinKeep/src/utils/walletsList.dart';

import '../../firebase/lib/src/models/wallet_model.dart';

class WalletsMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final dynamic walletName; // Додаємо колбек для зміни
  const WalletsMenu({
    super.key,
    required this.onChanged,
    required this.walletName,
  });

  @override
  _WalletsMenuState createState() => _WalletsMenuState();
}

class _WalletsMenuState extends State<WalletsMenu> {
  List<Wallet> walletsList = WalletsList().getAllWallets();

  List<DropdownMenuItem<String>> getDropdownMenuItem(List<Wallet> list) {
    List<DropdownMenuItem<String>> items = [];

    for (Wallet wallet in list.skip(1)) {
      var newItem = DropdownMenuItem<String>(
        value: wallet.walletTitle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Container(
            decoration: BoxDecoration(
              color: wallet.walletColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    // Вирішити проблему з паддінгами
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Text(
                      wallet.walletTitle,
                      style: dropDownStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      items.add(newItem);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: widget.walletName,
      hint: const Center(child: Text('Choose Wallet')),
      icon: const Padding(padding: EdgeInsets.only(right: 0)),
      items: getDropdownMenuItem(walletsList),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          widget.onChanged(newValue); // Викликаємо колбек
        }
      },
    );
  }
}
