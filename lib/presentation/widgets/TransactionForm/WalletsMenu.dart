import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/presentation/widgets/DefaultWallet.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletsMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final List<WalletEntity> walletsList;
  final String transactionWalletId;
  final bool isEditMode;

  const WalletsMenu({
    super.key,
    this.isEditMode = false,
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
    if (widget.isEditMode && widget.walletsList.isNotEmpty) {
      _selectedWalletIndex = widget.walletsList.indexWhere(
              (wallet) => wallet.walletId == widget.transactionWalletId) +
          1;
    } else {
      _selectedWalletIndex = 0;
    }
    // _selectedWalletIndex = 0;
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
        color: Theme.of(context).colorScheme.surface,
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
        child: const DefaultWallet(
          walletName: "No wallet selected",
          walletHeight: 250,
          walletColor: Colors.grey,
          walletStyle: kSmallText,
          infoVisible: false,
        ),
      )
    ];

    items.addAll(widget.walletsList.map((wallet) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
        child: DefaultWallet(
          walletName: wallet.walletName,
          walletHeight: 250,
          walletColor: ColorUtils.hexToColor(wallet.walletColor!),
          walletStyle: kSmallText,
          infoVisible: false,
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

    return GestureDetector(
      onTap: () {
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
      child: DefaultWallet(
        walletName: buttonText,
        walletHeight: 52,
        walletColor: buttonColor,
        walletStyle: kSmallTextP,
        infoVisible: false,
      ),
    );
  }
}
