// import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/screens/dashboard/BottomNavItems.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/dasboardUtils.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardScreen> {
  //Індекс вибраного елемента
  int _selectedIndex = 0;

  // Ініціалізація - LocalCacheBloc
  // final LocalCacheBloc _coinsBloc = LocalCacheBloc();

  // @override
  // void initState() {
  //   super.initState();
  //   //Подія для - LocalCacheBloc
  //   _coinsBloc.add(CacheStarted());
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBg,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Center(
              child: BottomNavItems.getWidgets().elementAt(_selectedIndex),
            );
          },
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) => _bottomNavigationBarExample(context),
      ),
    );
  }

  Widget _bottomNavigationBarExample(BuildContext context) {
    // Колірна схема
    final colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      items: BottomNavItems.getBottoms(
        colorScheme,
        navButtonsNames,
        navButtonsIcons,
      ),
      selectedLabelStyle: kNavBarTextStyle,
      currentIndex: _selectedIndex,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
