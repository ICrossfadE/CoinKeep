import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          onSurface: Colors.white,
          primary: kConfirmColor,
          background: Colors.white54,
        ),
      ),
      routes: pageRoutes,
      initialRoute: '/',
    );
  }
}
