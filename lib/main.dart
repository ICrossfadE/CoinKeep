import 'package:CoinKeep/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 65, 176, 110),
          onPrimary: Color.fromARGB(255, 27, 27, 27),
          secondary: Color.fromARGB(255, 27, 27, 27),
          onSecondary: Color.fromRGBO(104, 109, 118, 1),
          surface: Color.fromARGB(255, 255, 255, 255),
          onSurface: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
