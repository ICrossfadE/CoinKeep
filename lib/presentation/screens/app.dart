import 'package:CoinKeep/firebase/lib/user_repository.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
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
          BlocProvider<AssetCubit>(
            create: (context) => AssetCubit(
              context.read<GetTransactionsCubit>(),
            ),
          )
        ],
        child: const AppView(),
      ),
    );
  }
}
