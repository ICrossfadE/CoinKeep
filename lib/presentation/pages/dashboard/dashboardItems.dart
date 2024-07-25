import 'package:flutter/material.dart';

import '../assets/AssetsPage.dart';
import '../profile/ProfilePage.dart';
import '../transactions/TransactionsPage.dart';
import '../wallets/WalletsPage.dart';
import 'widgets/HorizontalScrollList.dart';

class BottomNavItems {
  //Масив кнопок для перемикання
  static List<BottomNavigationBarItem> getBottoms(
      ColorScheme colorScheme, List<String> bottonsList, iconList) {
    List<BottomNavigationBarItem> items = [];

    for (String buttonName in bottonsList) {
      var newItem = BottomNavigationBarItem(
        icon: iconList[buttonName],
        label: buttonName,
        backgroundColor: colorScheme.secondary,
      );

      items.add(newItem);
    }

    return items;
  }

  //Масив віджетів для перемикання
  static List<Widget> getWidgets() {
    return const [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [HorizontalScrollList()],
      ),
      WalletsPage(),
      AssetsPage(),
      TransactionsPage(),
      ProfilePage(),
    ];
  }
}
