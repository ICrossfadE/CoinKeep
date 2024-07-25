import 'package:CoinKeep/data/utilities/constans/transactionCanstants.dart';
import 'package:CoinKeep/data/utilities/constans/walletsList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/wallet_model.dart';

class WallletsMenu extends StatefulWidget {
  const WallletsMenu({super.key});

  @override
  State<WallletsMenu> createState() => _WallletsMenuState();
}

class _WallletsMenuState extends State<WallletsMenu> {
  String? chooseWalet;

  List<Wallet> walletsList = WalletsList().getAllWallets();

  void _changeWallet(wallet) {
    setState(() {
      chooseWalet = wallet;
    });
  }

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
      value: chooseWalet,
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
        setState(() {
          chooseWalet = newValue;
        });
      },
    );
  }
}
