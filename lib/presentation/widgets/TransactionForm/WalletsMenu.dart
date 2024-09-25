import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class WalletsMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final List<WalletEntity> walletsList;
  final String transactionWalletId;
  const WalletsMenu({
    super.key,
    required this.walletsList,
    required this.onChanged,
    required this.transactionWalletId,
  });

  @override
  _WalletsMenuState createState() => _WalletsMenuState();
}

class _WalletsMenuState extends State<WalletsMenu> {
  @override
  void initState() {
    super.initState();
    widget.walletsList;
  }

  List<DropdownMenuItem<String>> getDropdownMenuItem(List<WalletEntity> list) {
    return list.skip(0).map((wallet) {
      return DropdownMenuItem<String>(
        // Значення яке ми передаємо в firestore
        value: wallet.walletId,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.hexToColor(wallet.walletColor!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Text(
                      // Значення які відображаються
                      wallet.walletName!,
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
      dropdownColor: kDark500,
      value: widget.walletsList
              .any((wallet) => wallet.walletId == widget.transactionWalletId)
          ? widget.transactionWalletId
          : null,
      hint: const Center(
        child: Text(
          'Choose Wallet',
          style: TextStyle(color: Colors.white38),
        ),
      ),
      icon: const Padding(padding: EdgeInsets.only(right: 0)),
      items: getDropdownMenuItem(widget.walletsList),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ), // Забирає всі бордери
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white12,
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
    );
  }
}
