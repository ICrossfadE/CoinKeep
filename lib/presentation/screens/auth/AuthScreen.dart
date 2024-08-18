import 'package:CoinKeep/logic/blocs/login_google_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAScreen extends StatelessWidget {
  const AuthAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOGIN',
          textAlign: TextAlign.center,
        ),
        backgroundColor: colorScheme.primary,
      ),
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().logInWithGoogle();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(colorScheme.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/google.png'),
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
