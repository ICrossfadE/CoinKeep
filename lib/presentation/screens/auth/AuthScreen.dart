import 'dart:ui';

import 'package:CoinKeep/logic/blocs/login_google_cubit/login_cubit.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAScreen extends StatefulWidget {
  const AuthAScreen({super.key});

  @override
  State<AuthAScreen> createState() => _AuthAScreenState();
}

class _AuthAScreenState extends State<AuthAScreen> {
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

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 4), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Align(
                alignment: const AlignmentDirectional(3, -1.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kConfirmColor,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 3), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Align(
                alignment: const AlignmentDirectional(0, -1.6),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kCancelColor,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 2), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Align(
                alignment: const AlignmentDirectional(-3, -1.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kConfirmColor,
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 2), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/CoinKeep.png'),
                        height: 42,
                      ),
                      Text(
                        'CoinKeep',
                        style: kSmallText.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Text(
                    'Sign Up Account',
                    style: kMediumText.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your personal data to create your account',
                    style: kTextP.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(130),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: WidthButton(
                      buttonColor: Colors.transparent,
                      buttonText: 'Sign in with Google',
                      buttonTextStyle: kSmallText,
                      buttonImageIcon: 'assets/google.png',
                      borderRadius: 10,
                      buttonBorder: const BorderSide(
                        color: Colors.white38,
                        width: 2,
                      ),
                      onPressed: () {
                        context.read<LoginCubit>().logInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
