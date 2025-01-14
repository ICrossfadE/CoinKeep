import 'package:CoinKeep/presentation/widgets/DefaultWallet.dart';
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
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

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
  int focusedIndex = 0;

  void _onItemFocus(int index) {
    setState(() {
      focusedIndex = index;
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
            style: kSmallText,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputText(
                hintName: 'New wallet name',
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
                    style: kConfirmButton,
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Закрити AlertDialog
              },
              child: const Text(
                'Cancel',
                style: kDefaultButton,
              ),
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
            style: kSmallText,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
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
            'Delete confirmation',
            style: kMediumText,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: Text(
            'Are you sure you want to delete this wallet?',
            style: kTextP.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(130),
            ),
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
                style: kCancelButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Закрити AlertDialog
              },
              child: const Text(
                'Cancel',
                style: kDefaultButton,
              ),
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selected Wallet: ${walletItem.walletName}',
                style: kSmallText,
              ),
              const SizedBox(height: 20),
              WidthButton(
                buttonText: 'Edit Text',
                buttonTextStyle: kSmallText,
                buttonColor: kEditColor.withAlpha(200),
                borderRadius: 10,
                buttonBorder: BorderSide(
                  width: 2,
                  color: Colors.white.withOpacity(0.2),
                ),
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
                          buttonColor: kDefaultlColor.withAlpha(160),
                          buttonText: 'Choise Color',
                          buttonTextStyle: kSmallText,
                          borderRadius: 10,
                          buttonBorder: BorderSide(
                            width: 2,
                            color: Colors.white.withOpacity(0.2),
                          ),
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
                buttonColor: kCancelColor.withAlpha(160),
                buttonText: 'Delete',
                buttonTextStyle: kSmallText,
                borderRadius: 10,
                buttonBorder: BorderSide(
                  width: 2,
                  color: Colors.white.withOpacity(0.2),
                ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ScrollSnapList(
          onItemFocus: _onItemFocus,
          scrollDirection: Axis.vertical,
          itemSize: 250,
          itemBuilder: _buildListItem,
          itemCount: widget.wallets.length,
          dynamicItemSize: true,
        ),
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
        child: DefaultWallet(
          walletName: walletItem.walletName,
          walletHeight: 250,
          walletColor: ColorUtils.hexToColor(walletItem.walletColor!),
          walletStyle: kLargeText,
          infoVisible: false,
        ));
  }
}
