import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalScrollList extends StatefulWidget {
  @override
  State<HorizontalScrollList> createState() => _HorizontalScrollListState();
}

class _HorizontalScrollListState extends State<HorizontalScrollList> {
  List<String> data = ['Total Balance', 'Binance', 'MetaMask', 'OKX', 'Keplr'];
  int _focusedIndex = 0; //future

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Swiper(
          itemBuilder: _buildListItem,
          pagination: const SwiperPagination(margin: EdgeInsets.all(1.0)),
          itemCount: data.length,
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
      padding: EdgeInsets.fromLTRB(5, 0, 5, 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            data[index],
            style: TextStyle(fontSize: 50.0, color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _onFocusItem(int index) {
    return setState(() {
      _focusedIndex = index;
      print('Item index $_focusedIndex');
    });
  }
}
