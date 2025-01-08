import 'package:CoinKeep/logic/blocs/theme_switch_bloc/theme_switch_bloc.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
// import 'package:CoinKeep/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSwitchBloc, ThemeSwitchState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          // darkTheme: darkMode,
          routes: pageRoutes,
          initialRoute: '/',
        );
      },
    );
  }
}
