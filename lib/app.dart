import 'package:CoinKeep/app_view.dart';
import 'package:CoinKeep/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

// import 'logic/blocs/local_cache_Bloc/local_cache_bloc.dart';

class MyApp extends StatelessWidget {
  // Ініціалізація - LocalCacheBloc
  // final LocalCacheBloc _coinsBloc = LocalCacheBloc();
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  // Головний Інтерфейс
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthBloc>(
      create: (appContext) => AuthBloc(userRepository: userRepository),
      child: Builder(
        builder: (context) => const AppView(),
      ),
    );
  }
}
