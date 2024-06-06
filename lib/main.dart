import 'package:CoinKeep/presentation/widgets/HorizontalScrollListWidget.dart';
import 'package:CoinKeep/presentation/widgets/TransactionsWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Text Styles
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey);

  // Widget List
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [HorizontalScrollList()],
    ),
    const Text(
      'Index 1: Assets',
      style: optionStyle,
    ),
    Builder(builder: (context) => const TransactionsWidget()),
    const Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext appContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 65, 176, 110), // колір вибраних
          onPrimary: Color.fromARGB(255, 46, 46, 46),
          secondary: Color.fromARGB(255, 27, 27, 27),
          onSecondary: Color.fromRGBO(104, 109, 118, 1),
          surface: Color.fromARGB(255, 189, 189, 189), //колір кнопок навігації
          onSurface: Color.fromARGB(255, 46, 46, 46), //колір bg
        ),
      ),
      home: Builder(
        builder: (appContext) => _widgetsBar(appContext),
      ),
    );
  }

  Widget _widgetsBar(BuildContext widgetsContext) {
    final colorScheme = Theme.of(widgetsContext).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onSurface,
      appBar: AppBar(
        title: const Text(
          'CoinKeep',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.secondary,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Builder(
        builder: (widgetsContext) =>
            _bottomNavigationBarExample(widgetsContext),
      ),
    );
  }

  Widget _bottomNavigationBarExample(BuildContext nawButtonsContext) {
    final colorScheme = Theme.of(nawButtonsContext).colorScheme;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
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
      currentIndex: _selectedIndex,
      selectedItemColor: colorScheme.primary,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }
}
