import 'dart:ui';

import 'package:CoinKeep/logic/blocs/login_google_cubit/login_cubit.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAScreen extends StatelessWidget {
  const AuthAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBg,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -1.3), //(x, y)
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kConfirmColor,
                ),
              ),
            ),
            Align(
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
            Align(
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
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/CoinKeep.png'),
                        height: 42,
                      ),
                      Text(
                        'CoinKeep',
                        style: kSmallText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Sign Up Account',
                    style: kMediumText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter your personal data to create your account',
                    style: kSmallTextP,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: WidthButton(
                      buttonColor: Colors.transparent,
                      buttonText: 'Sign in with Google',
                      buttonTextStyle: kSmallText,
                      buttonImageIcon: 'assets/google.png',
                      borderRadius: 10,
                      buttonBorder:
                          const BorderSide(color: Colors.white38, width: 2),
                      onPressed: () {
                        context.read<LoginCubit>().logInWithGoogle();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
