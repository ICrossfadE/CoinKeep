import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';

class WalletsScreen extends StatelessWidget {
  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kDarkBg,
      body: Center(
          child: Text(
        'Wallets',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
