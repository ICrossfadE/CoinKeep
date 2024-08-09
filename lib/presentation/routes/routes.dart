import 'package:CoinKeep/presentation/screens/transactions/AddTransactionScreeen.dart';
import 'package:CoinKeep/presentation/screens/transactions/FormTransactionScreean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// logic
import 'package:CoinKeep/firebase/lib/user_repository.dart';
import '../../logic/blocs/auth_google_bloc/auth_google_bloc.dart';
import '../../logic/blocs/login_google_cubit/login_cubit.dart';

// pages
import '../screens/auth/AuthPage.dart';
import '../screens/dashboard/DashboardPage.dart';

class RouteId {
  static const welcome = '/';
  static const addTransaction = '/add-transaction';
  static const formTransaction = '/form-transaction';
}

Map<String, Widget Function(BuildContext)> pageRoutes = {
  RouteId.welcome: (context) => BlocBuilder<AuthGoogleBloc, AuthGoogleState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return BlocProvider(
              create: (context) => AuthGoogleBloc(
                authRepository: context.read<AuthGoogleBloc>().authRepository,
              ),
              child: const DashboardPage(),
            );
          } else {
            return BlocProvider(
              create: (_) => LoginCubit(context.read<AuthRepository>()),
              child: const AuthPage(),
            );
          }
        },
      ),
  RouteId.addTransaction: (context) => const AddTransactionScreeen(),
  RouteId.formTransaction: (context) => const FormTransactionScreean()
};
