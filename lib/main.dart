import 'package:CoinKeep/firebase_options.dart';
import 'package:CoinKeep/logic/bloc/local_cache/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/widgets/HorizontalScrollListWidget.dart';
import 'package:CoinKeep/presentation/widgets/TransactionsWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  // Для кешування
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Ініціалізація - LocalCacheBloc
  final LocalCacheBloc _coinsBloc = LocalCacheBloc();

  //Індекс вибраного елемента
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    //Подія для - LocalCacheBloc
    _coinsBloc.add(CacheStarted());

    // test auth
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('no USER');
        } else {
          print('user $user');
        }
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  //Стиль для тексту
  // !
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey);

  //Масив віджетів для перемикання
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [HorizontalScrollList()],
    ),
    const Text(
      'Index 1: Assets',
      style: optionStyle,
    ),
    const TransactionsWidget(),
    const Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  @override
  // Головний Інтерфейс
  Widget build(BuildContext appContext) {
    return BlocProvider(
      // Передаємо _coinsBloc для дочірних елементів
      create: (appContext) => _coinsBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoinKeep',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 65, 176, 110), // колір вибраних
            onPrimary: Color.fromARGB(255, 46, 46, 46),
            secondary: Color.fromARGB(255, 27, 27, 27),
            onSecondary: Color.fromRGBO(104, 109, 118, 1),
            surface:
                Color.fromARGB(255, 189, 189, 189), //колір кнопок навігації
            onSurface: Color.fromARGB(255, 46, 46, 46), //колір bg
          ),
        ),
        home: Builder(
          builder: (appContext) => _widgetsBar(appContext),
        ),
      ),
    );
  }

  Widget _widgetsBar(BuildContext widgetsContext) {
    // Колірна схема
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
        // Динамічний список віджетів
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Builder(
        builder: (widgetsContext) =>
            _bottomNavigationBarExample(widgetsContext),
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
}
