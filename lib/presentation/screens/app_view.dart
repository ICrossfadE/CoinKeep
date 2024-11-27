import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          surface: kDark500,
          onSurface: Colors.white,
          primary: Color(0xFF3ABEF9),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kDark500, // Глобальний стиль для всіх AppBar
        ),
      ),
      routes: pageRoutes,
      initialRoute: '/',
    );
  }
}
