import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class AuthPlaceholder extends StatelessWidget {
  const AuthPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/CoinKeep.png'),
              height: 124,
            ),
            SizedBox(height: 10),
            Text(
              'CoinKeep',
              textAlign: TextAlign.center,
              style: kAppBarStyle,
            ),
          ],
        ),
      ),
    );
  }
}
