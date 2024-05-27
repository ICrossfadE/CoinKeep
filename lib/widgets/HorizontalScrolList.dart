import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HorizontalScrolList extends StatefulWidget {
  // const Horizontalscrollist({super.key});

  @override
  State<HorizontalScrolList> createState() => _HorizontalScrolListState();
}

class _HorizontalScrolListState extends State<HorizontalScrolList> {
  List<String> data = ['Total Balance', 'Binance', 'MetaMask', 'OKX', 'Keplr'];
  int _focusedIndex = 0;

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
      print('wallet index - $index');
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == data.length) {
      return const Center(
        // !
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // !
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // !
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Center(
                child: Text(
                  data[index],
                  style: TextStyle(fontSize: 50.0, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //!
    return Expanded(
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        onItemFocus: _onItemFocus,
        itemSize: MediaQuery.of(context).size.width,
        dynamicItemSize: false,
        onReachEnd: () {
          print('wallet index - 5');
        },
        itemCount: data.length,
      ),
    );
  }
}
