import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';

import '../assets/AssetsScreen.dart';
import '../profile/ProfileScreen.dart';
import '../transactions/TransactionsScreean.dart';
import '../wallets/WalletsScreen.dart';
import '../../widgets/HorizontalSwipeList.dart';

class BottomNavItems {
  //Масив кнопок для перемикання
  static List<BottomNavigationBarItem> getBottoms(
      ColorScheme colorScheme, List<String> bottonsList, iconList) {
    List<BottomNavigationBarItem> items = [];

    for (String buttonName in bottonsList) {
      var newItem = BottomNavigationBarItem(
        icon: iconList[buttonName],
        label: buttonName,
        backgroundColor: kDark500,
      );

      items.add(newItem);
    }

    return items;
  }

  //Масив віджетів для перемикання
  static List<Widget> getWidgets(List<WalletEntity> wallets) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [HorizontalSwipeList(wallets: wallets)],
      ),
      const WalletsScreen(),
      const AssetsScreen(),
      const TransactionsScreen(),
      const ProfileScreen(),
    ];
  }
}
