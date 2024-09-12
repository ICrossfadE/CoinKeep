import 'package:CoinKeep/presentation/routes/routes.dart';
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
          surface: Colors.white,
          onSurface: Color.fromARGB(255, 255, 255, 255),
          primary: Color(0xFF3ABEF9),
        ),
      ),
      routes: pageRoutes,
      initialRoute: '/',
    );
  }
}
