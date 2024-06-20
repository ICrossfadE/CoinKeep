import 'package:CoinKeep/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:CoinKeep/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:CoinKeep/presentation/pages/auth/AuthPage.dart';
import 'package:CoinKeep/presentation/pages/dashboard/DashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoinKeep',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            surface: Colors.white, //bg
            onSurface: Colors.black, //bg
            primary: Color.fromRGBO(58, 190, 249, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(41, 41, 41, 1),
            onSecondary: Colors.white,
            tertiary: Color.fromRGBO(255, 204, 128, 1),
            error: Colors.red,
            outline: Color(0xFF424242)),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                  userRepository: context.read<AuthBloc>().userRepository),
              child: const DashboardPage(),
            );
          } else {
            return AuthPage(context);
          }
        },
      ),
    );
  }
}
