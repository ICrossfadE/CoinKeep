import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/pages/assets/AssetsPage.dart';
import 'package:CoinKeep/presentation/pages/profile/ProfilePage.dart';
import 'package:CoinKeep/presentation/pages/wallets/WalletsPage.dart';
import 'package:CoinKeep/presentation/widgets/HorizontalScrollList.dart';
import 'package:CoinKeep/presentation/pages/transactions/TransactionsPage.dart';
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

  //Масив віджетів для перемикання
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [HorizontalScrollList()],
    ),
    const WalletsPage(),
    const AssetsPage(),
    const TransactionsPage(),
    const ProfilePage(),
  ];

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
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: colorScheme.secondary,
        ),
        body: Builder(builder: (dashboardContext) {
          return Center(
            // Динамічний список віджетів
            child: _widgetOptions.elementAt(_selectedIndex),
          );
        }),
        bottomNavigationBar: Builder(
          builder: (dashboardContext) =>
              _bottomNavigationBarExample(dashboardContext),
        ),
      ),
    );
  }

  Widget _bottomNavigationBarExample(BuildContext nawButtonsContext) {
    // Колірна схема
    final colorScheme = Theme.of(nawButtonsContext).colorScheme;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
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
      ],
      selectedLabelStyle: const TextStyle(fontFamily: 'PlusJakartaSans'),
      currentIndex: _selectedIndex,
      selectedItemColor: colorScheme.primary,
      onTap: _onItemTapped,
    );
  }
}
