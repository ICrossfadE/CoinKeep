import 'package:CoinKeep/presentation/screens/assets/DetailsAssetScreen.dart';
import 'package:CoinKeep/presentation/screens/transactions/AddTransactionScreeen.dart';
import 'package:CoinKeep/presentation/screens/transactions/FormTransactionScreean.dart';
// import 'package:CoinKeep/presentation/screens/transactions/TransactionsScreean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// logic
import 'package:CoinKeep/firebase/lib/user_repository.dart';
import '../../logic/blocs/auth_google_bloc/auth_google_bloc.dart';
import '../../logic/blocs/login_google_cubit/login_cubit.dart';

// pages
import '../screens/auth/AuthScreen.dart';
import '../screens/dashboard/DashboardScreen.dart';
import '../screens/transactions/TransactionsScreean.dart';

class RouteId {
  static const welcome = '/';
  static const screenTransaction = '/screen-transaction';
  static const addTransaction = '/add-transaction';
  static const formTransaction = '/form-transaction';
  static const assetDetails = '/asset-details';
}

Map<String, Widget Function(BuildContext)> pageRoutes = {
  RouteId.welcome: (context) => BlocBuilder<AuthGoogleBloc, AuthGoogleState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return BlocProvider(
              create: (context) => AuthGoogleBloc(
                authRepository: context.read<AuthGoogleBloc>().authRepository,
              ),
              child: const DashboardScreen(),
            );
          } else {
            return BlocProvider(
              create: (_) => LoginCubit(context.read<AuthRepository>()),
              child: const AuthAScreen(),
            );
          }
        },
      ),
  RouteId.screenTransaction: (context) => const TransactionsScreen(),
  RouteId.addTransaction: (context) => const AddTransactionScreeen(),
  RouteId.formTransaction: (context) => const FormTransactionScreean(),
  RouteId.assetDetails: (context) => const DetailsAssetScreen(),
};
