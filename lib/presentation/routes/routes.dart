import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/screens/assets/DetailsAssetScreen.dart';
import 'package:CoinKeep/presentation/screens/auth/AuthPlaceholder.dart';
import 'package:CoinKeep/presentation/screens/transactions/EditTransactionScreen.dart';
import 'package:CoinKeep/presentation/screens/transactions/SearchCoinsScreen.dart';
import 'package:CoinKeep/presentation/screens/transactions/CreateTransactionScreean.dart';
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
  static const searchCoins = '/search-coins';
  static const createTransaction = '/create-transaction';
  static const editTransaction = '/edit-transaction';
  static const assetDetails = '/asset-details';
}

Map<String, Widget Function(BuildContext)> pageRoutes = {
  RouteId.welcome: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthGoogleBloc>(
            create: (context) => AuthGoogleBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LocalCacheBloc>(
            create: (context) => LocalCacheBloc()
              ..add(
                  CacheStarted()), // Додаємо блок в провайдер для всіх дочірніх віджетів
          ),
        ],
        child: BlocBuilder<AuthGoogleBloc, AuthGoogleState>(
          builder: (context, authState) {
            return BlocBuilder<LocalCacheBloc, LocalCacheState>(
              builder: (context, cacheState) {
                if (authState.status == AuthStatus.authenticated) {
                  if (cacheState.status == CacheStatus.success) {
                    return const DashboardScreen();
                  }
                  return const AuthPlaceholder();
                } else {
                  return BlocProvider(
                    create: (_) => LoginCubit(context.read<AuthRepository>()),
                    child: const AuthAScreen(),
                  );
                }
              },
            );
          },
        ),
      ),
  RouteId.screenTransaction: (context) => const TransactionsScreen(),
  RouteId.searchCoins: (context) => const SearchCoinsScreen(),
  RouteId.createTransaction: (context) => const CreateTransactionScreean(),
  RouteId.editTransaction: (context) => const EditTransactionScreen(),
  RouteId.assetDetails: (context) => const DetailsAssetScreen(),
};
