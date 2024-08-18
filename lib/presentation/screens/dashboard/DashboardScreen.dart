import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/screens/dashboard/BottomNavItems.dart';
import 'package:CoinKeep/presentation/screens/dashboard/widgetConstans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../src/constants/mainConstant.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardScreen> {
  // Ініціалізація - LocalCacheBloc
  final LocalCacheBloc _coinsBloc = LocalCacheBloc();

  //Індекс вибраного елемента
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    //Подія для - LocalCacheBloc
    _coinsBloc.add(CacheStarted());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Колірна схема
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => _coinsBloc,
      child: Scaffold(
        backgroundColor: colorScheme.onSurface,
        appBar: AppBar(
          title: const Text(
            'CoinKeep',
            style: appBarStyle,
          ),
          centerTitle: true,
          backgroundColor: colorScheme.secondary,
        ),
        body: Builder(builder: (context) {
          return Center(
            // Динамічний список віджетів
            child: BottomNavItems.getWidgets().elementAt(_selectedIndex),
          );
        }),
        bottomNavigationBar: Builder(
          builder: (context) => _bottomNavigationBarExample(context),
        ),
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
      selectedLabelStyle: navBarTextStyle,
      currentIndex: _selectedIndex,
      selectedItemColor: colorScheme.primary,
      onTap: _onItemTapped,
    );
  }
}
