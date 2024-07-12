import 'package:CoinKeep/presentation/widgets/walletsList.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'widgetConstans.dart';

WalletsList walletData = WalletsList();

class HorizontalScrollList extends StatefulWidget {
  const HorizontalScrollList({super.key});

  @override
  State<HorizontalScrollList> createState() => _HorizontalScrollListState();
}

class _HorizontalScrollListState extends State<HorizontalScrollList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Swiper(
          itemBuilder: _buildListItem,
          pagination: const SwiperPagination(margin: EdgeInsets.all(1.0)),
          itemCount: walletData.getWalletsLength(),
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
          color: walletData.getWalletColor(index),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                walletData.getWalletsTitle(index),
                style: styleWalletTitle,
              ),
              Text(
                '+${walletData.getWalletsPercent(index)}%',
                style: styleWalletProfit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFocusItem(int index) {
    return setState(() {
      walletData.updateFocusedIndex(index);
      print('Item index ${walletData.updateFocusedIndex(index)}');
    });
  }
}
