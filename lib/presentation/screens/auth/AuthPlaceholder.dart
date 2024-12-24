import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';

class AuthPlaceholder extends StatefulWidget {
  const AuthPlaceholder({super.key});

  @override
  State<AuthPlaceholder> createState() => _AuthplaceholderState();
}

class _AuthplaceholderState extends State<AuthPlaceholder> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kDarkBg,
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _opacity,
            curve: Curves.easeInOut,
            child: const Column(
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
                  style: kSmallText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
