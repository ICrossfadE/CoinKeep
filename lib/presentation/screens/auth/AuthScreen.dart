import 'package:CoinKeep/logic/blocs/login_google_cubit/login_cubit.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAScreen extends StatelessWidget {
  const AuthAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: WidthButton(
                  buttonColor: kDark500,
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
      ),
    );
  }
}
