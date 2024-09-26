import 'package:CoinKeep/firebase/lib/user_repository.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/screens/app_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/auth_google_bloc/auth_google_bloc.dart';

class MyApp extends StatelessWidget {
  //Отримуємо екземпляр authReositorya
  final AuthRepository authReository;
  const MyApp(this.authReository, {super.key});

  @override
  // Головний Інтерфейс
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authReository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthGoogleBloc>(
            create: (context) => AuthGoogleBloc(authRepository: authReository),
          ),
          BlocProvider<GetTransactionsCubit>(
            create: (context) => GetTransactionsCubit(FirebaseAuth.instance),
          ),
          BlocProvider<LocalCacheBloc>(
            create: (context) => LocalCacheBloc(),
          ),
          BlocProvider<AssetCubit>(
            create: (context) => AssetCubit(
              context.read<GetTransactionsCubit>(),
              context.read<LocalCacheBloc>(),
            ),
          ),
          BlocProvider<TransactionBloc>(
            create: (context) => TransactionBloc(FirebaseAuth.instance),
          ),
          BlocProvider<GetWalletCubit>(
            create: (context) => GetWalletCubit(FirebaseAuth.instance),
          ),
          BlocProvider<SetWalletBloc>(
            create: (context) => SetWalletBloc(FirebaseAuth.instance),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
