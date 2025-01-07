import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/src/theme/theme.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'CoinKeep',
      // theme: ThemeData(
      //   colorScheme: const ColorScheme.dark(
      //     // onSurface: Colors.white,
      //     // primary: kConfirmColor,
      //     surface: kConfirmColor,
      //     background: Colors.white54,
      //   ),
      // ),
      theme: lightMode,
      darkTheme: darkMode,
      routes: pageRoutes,
      initialRoute: '/',
    );
  }
}
