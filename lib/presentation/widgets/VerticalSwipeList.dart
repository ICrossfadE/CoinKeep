import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/presentation/widgets/ColorPicker.dart';
import 'package:CoinKeep/presentation/widgets/InputText.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';

class VerticalSwipeList extends StatefulWidget {
  final List<WalletEntity> wallets;

  const VerticalSwipeList({
    required this.wallets,
    super.key,
  });

  @override
  State<VerticalSwipeList> createState() => _VerticalSwipeListState();
}

class _VerticalSwipeListState extends State<VerticalSwipeList> {
  void _onFocusItem(int index) {
    setState(() {
      widget.wallets[index];
    });
  }

  void _showEditName(BuildContext context, int index) {
    final walletItem = widget.wallets[index];

    TextEditingController controller =
        TextEditingController(text: walletItem.walletName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Edit Wallet Name',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kDark500,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputText(
                hintName: 'Enter new name here',
                textController: controller,
              ),
            ],
          ),
          actions: [
            BlocBuilder<SetWalletBloc, SetWalletState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: () {
                    // Змінюємо текст
                    context.read<SetWalletBloc>().add(Update(
                          walletId: walletItem.walletId!,
                          newWalletName: controller.text,
                        ));
                    // Виходимо на головну сторінку
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(RouteId.welcome),
                    );
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: kConfirmColor),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Закрити AlertDialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditColor(BuildContext context, int index, String newColor) {
    final walletItem = widget.wallets[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose Color',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kDark500,
          content: ColorPicker(
            initialColor: walletItem.walletColor,
            onConfirm: (Color color) {
              // Оновлюємо колір
              context.read<SetWalletBloc>().add(
                    Update(
                      walletId: walletItem.walletId!,
                      newWalletColor: ColorUtils.colorToHex(color),
                    ),
                  );
            },
          ),
        );
      },
    );
  }

  void _showDeleteAlert(BuildContext context, int index) {
    final walletItem = widget.wallets[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kDark500,
          content: const Text(
            'Are you sure you want to delete this wallet?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Видалення
                context.read<SetWalletBloc>().add(Delete(walletItem.walletId!));
                // Повернення на головну сторінку
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(RouteId.welcome),
                ); // Закрити AlertDialog
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: kCancelColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Закрити AlertDialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, int index) {
    final walletItem = widget.wallets[index];

    showModalBottomSheet(
      context: context,
      backgroundColor: kDark500,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selected Wallet: ${walletItem.walletName}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              WidthButton(
                buttonText: 'Edit Text',
                buttonColor: kEditColor,
                onPressed: () {
                  _showEditName(context, index);
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SetWalletBloc, SetWalletState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: WidthButton(
                          buttonColor: kDefaultlColor,
                          buttonText: 'Choise Color',
                          buttonTextStyle: kWidthButtonStyle,
                          onPressed: () => _showEditColor(
                            context,
                            index,
                            '${walletItem.walletColor}',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              WidthButton(
                buttonText: 'Delete',
                buttonColor: kCancelColor,
                onPressed: () {
                  _showDeleteAlert(context, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Swiper(
        itemBuilder: _buildListItem,
        itemCount: widget.wallets.length,
        scrollDirection: Axis.vertical,
        itemHeight: 330,
        itemWidth: MediaQuery.of(context).size.width,
        layout: SwiperLayout.STACK,
        loop: true,
        onIndexChanged: (int index) {
          _onFocusItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final walletItem = widget.wallets[index];

    return GestureDetector(
      onTap: () {
        // Виклик BottomSheet при натисканні
        _showBottomSheet(context, index);
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.hexToColor(walletItem.walletColor!),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${walletItem.walletName}',
                    style: styleWalletTitle,
                  ),
                  // Text(
                  //   '+${walletData.getWalletsPercent(index)}%',
                  //   style: styleWalletProfit,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
