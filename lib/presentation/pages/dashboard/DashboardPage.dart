import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/pages/dashboard/dashboardConstant.dart';
import 'package:CoinKeep/presentation/pages/dashboard/dashboardItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Ініціалізація - LocalCacheBloc
  final LocalCacheBloc _coinsBloc = LocalCacheBloc();

  //Індекс вибраного елемента
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext dashboardContext) {
    // Колірна схема
    final colorScheme = Theme.of(dashboardContext).colorScheme;

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
        body: Builder(builder: (dashboardContext) {
          return Center(
            // Динамічний список віджетів
            child: BottomNavItems.getWidgets().elementAt(_selectedIndex),
          );
        }),
        bottomNavigationBar: Builder(
          builder: (dashboardContext) =>
              _bottomNavigationBarExample(dashboardContext),
        ),
      ),
    );
  }

  Widget _bottomNavigationBarExample(BuildContext context) {
    // Колірна схема
    final colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      items: BottomNavItems.getBottoms(colorScheme),
      selectedLabelStyle: navBarTextStyle,
      currentIndex: _selectedIndex,
      selectedItemColor: colorScheme.primary,
      onTap: _onItemTapped,
    );
  }

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
}
