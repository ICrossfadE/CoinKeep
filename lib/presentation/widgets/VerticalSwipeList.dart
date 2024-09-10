import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/utils/colors.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

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

  // Функція для перетворення HEX у Color
  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor; // Додаємо прозорість 100% (FF)
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  void _showDeleteAlert(BuildContext context, int index) {
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
                // Дія для видалення
                Navigator.pop(context); // Закрити AlertDialog
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

  void _showEditDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(
          text:
              '${widget.wallets[index].walletName}', // Попередньо заповнений текст
        );

        return AlertDialog(
          title: const Text(
            'Edit Wallet Name',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kDark500,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter new name here',
                  hintStyle: const TextStyle(color: Colors.white12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Дія для збереження нової назви
                print('Submitting new name: ${controller.text}');
                // walletData.updateWalletTitle(index, controller.text);
                Navigator.pop(context); // Закрити AlertDialog
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: kConfirmColor),
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
                'Selected Wallet: ${widget.wallets[index].walletName}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              WidthButton(
                buttonText: 'Edit Text',
                buttonColor: kEditColor,
                onPressed: () {
                  _showEditDialog(context,
                      index); // Відкриття модального вікна для редагування
                  // Navigator.pop(context); // Закрити BottomSheet
                },
              ),
              const SizedBox(height: 10),
              WidthButton(
                buttonText: 'Edit Color',
                buttonColor: kDefaultlColor,
                onPressed: () {
                  _showEditDialog(context,
                      index); // Відкриття модального вікна для редагування
                  // Navigator.pop(context); // Закрити BottomSheet
                },
              ),
              const SizedBox(height: 10),
              WidthButton(
                buttonText: 'Delete',
                buttonColor: kCancelColor,
                onPressed: () {
                  _showDeleteAlert(context, index);
                  // Navigator.pop(context); // Закрити BottomSheet
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
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context, index); // Виклик BottomSheet при натисканні
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 80),
          child: Container(
            decoration: BoxDecoration(
              color: getColorFromHex(widget.wallets[index].walletColor!),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.wallets[index].walletName}',
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
