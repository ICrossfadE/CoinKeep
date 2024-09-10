import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class HorizontalSwipeList extends StatefulWidget {
  final List<WalletEntity> wallets;

  const HorizontalSwipeList({
    required this.wallets,
    super.key,
  });

  @override
  State<HorizontalSwipeList> createState() => _HorizontalSwipeListState();
}

class _HorizontalSwipeListState extends State<HorizontalSwipeList> {
  void _onFocusItem(int index) {
    return setState(() {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Swiper(
          itemBuilder: _buildListItem,
          pagination: const SwiperPagination(margin: EdgeInsets.all(1.0)),
          itemCount: widget.wallets.length,
          loop: false,
          onIndexChanged: (int index) {
            _onFocusItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
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
    );
  }
}
