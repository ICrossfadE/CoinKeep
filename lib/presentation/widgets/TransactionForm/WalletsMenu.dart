import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:flutter/material.dart';

import 'package:CoinKeep/firebase/lib/src/models/wallet_model.dart';

import '../../../src/utils/walletsList.dart';

class WalletsMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String walletName;
  const WalletsMenu({
    super.key,
    required this.onChanged,
    required this.walletName,
  });

  @override
  _WalletsMenuState createState() => _WalletsMenuState();
}

class _WalletsMenuState extends State<WalletsMenu> {
  //Пізніше змінити на wslletState
  late List<Wallet> walletsList;

  @override
  void initState() {
    super.initState();
    walletsList = WalletsList().getAllWallets();
  }

  List<DropdownMenuItem<String>> getDropdownMenuItem(List<Wallet> list) {
    return list.skip(1).map((wallet) {
      return DropdownMenuItem<String>(
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
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Text(
                      wallet.walletTitle,
                      style: dropDownStyle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value:
          walletsList.any((wallet) => wallet.walletTitle == widget.walletName)
              ? widget.walletName
              : null,
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
          widget.onChanged(newValue);
        }
      },
    );
  }
}
