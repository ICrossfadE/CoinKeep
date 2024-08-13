import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            surface: Colors.white,
            onSurface: Color.fromARGB(255, 0, 0, 0),
            primary: Color.fromRGBO(58, 190, 249, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(41, 41, 41, 1),
            onSecondary: Colors.white,
            tertiary: Color.fromRGBO(255, 204, 128, 1),
            error: Colors.red,
            outline: Color(0xFF424242)),
      ),
      routes: pageRoutes,
      initialRoute: '/',
    );
  }
}
