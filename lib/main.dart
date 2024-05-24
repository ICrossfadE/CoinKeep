import 'package:coinkeep/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

// !
class MyApp extends StatelessWidget {
  // !
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // !
      debugShowCheckedModeBanner: false,
      title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            surface: Color.fromARGB(255, 255, 255, 255),
            onSurface: Color.fromARGB(255, 51, 51, 51),
            primary: Color.fromARGB(255, 80, 59, 173),
            onPrimary: Color.fromARGB(255, 51, 51, 51),
            secondary: Color.fromARGB(255, 21, 138, 66),
            onSecondary: Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const HomeScreen(),
    );
  }
}
