import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
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
  late int _selectedWalletIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedWalletIndex = 0;
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: kDark500,
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  List<Widget> _pickerItems() {
    List<Widget> items = [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "No wallet selected",
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
    ];

    items.addAll(widget.walletsList.map((wallet) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
        decoration: BoxDecoration(
          color: ColorUtils.hexToColor(wallet.walletColor!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  wallet.walletName,
                  style: dropDownStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ),
          ],
        ),
      );
    }));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = _selectedWalletIndex == 0
        ? "No wallet selected"
        : widget.walletsList[_selectedWalletIndex - 1].walletName;
    Color buttonColor = _selectedWalletIndex == 0
        ? const Color(0xFF757575)
        : ColorUtils.hexToColor(
            widget.walletsList[_selectedWalletIndex - 1].walletColor!);

    return WidthButton(
      buttonText: buttonText,
      buttonColor: buttonColor,
      borderRadius: 6,
      onPressed: () {
        _showDialog(
          CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: _selectedWalletIndex),
            itemExtent: 90,
            onSelectedItemChanged: (int selectedItem) {
              setState(() {
                _selectedWalletIndex = selectedItem;
              });
              if (selectedItem == 0 || widget.walletsList.isEmpty) {
                widget.onChanged('');
              } else {
                widget
                    .onChanged(widget.walletsList[selectedItem - 1].walletId!);
              }
            },
            children: _pickerItems(),
          ),
        );
      },
    );
  }
}
