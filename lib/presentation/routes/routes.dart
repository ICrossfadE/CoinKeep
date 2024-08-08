import 'package:CoinKeep/presentation/screens/transactions/AddTransactionPage.dart';
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

Map<String, Widget Function(BuildContext)> pageRoutes = {
  '/': (context) => BlocBuilder<AuthGoogleBloc, AuthGoogleState>(
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
  '/add-transaction': (context) => const AddTransactionPage(),
};
