import 'package:flutter/material.dart';

import 'widgets/HorizontalScrollList.dart';
import '../assets/AssetsPage.dart';
import '../profile/ProfilePage.dart';
import '../transactions/TransactionsPage.dart';
import '../wallets/WalletsPage.dart';

class BottomNavItems {
  //Масив кнопок для перемикання
  static List<BottomNavigationBarItem> getBottoms(ColorScheme colorScheme) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: 'Home',
        backgroundColor: colorScheme.secondary,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.account_balance_wallet),
        label: 'Wallets',
        backgroundColor: colorScheme.secondary,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.control_point_duplicate_rounded),
        label: 'Assets',
        backgroundColor: colorScheme.secondary,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.import_export_rounded),
        label: 'Transactions',
        backgroundColor: colorScheme.secondary,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: 'Profile',
        backgroundColor: colorScheme.secondary,
      ),
    ];
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
