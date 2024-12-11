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
                decoration: BoxDecoration(color: Colors.transparent),
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Sign Up Account',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter your personal data to create your account',
                    style: TextStyle(fontSize: 14, color: Colors.white54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: WidthButton(
                      buttonColor: Colors.transparent,
                      buttonText: 'Sign in with Google',
                      buttonTextStyle: kWidthButtonStyle,
                      buttonImageIcon: 'assets/google.png',
                      borderRadius: 10,
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

  //  Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 70),
  //               child: WidthButton(
  //                 buttonColor: kDark500,
  //                 buttonText: 'Sign in with Google',
  //                 buttonTextStyle: kWidthButtonStyle,
  //                 buttonImageIcon: 'assets/google.png',
  //                 borderRadius: 10,
  //                 onPressed: () {
  //                   context.read<LoginCubit>().logInWithGoogle();
  //                 },
  //               ),
  //             )
  //           ],
  //         ),
  //       ),