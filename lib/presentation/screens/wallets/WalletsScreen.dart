import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/widgets/HorizontalSwipeList.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletsScreen extends StatelessWidget {
  const WalletsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Отримуємо Блок
    final walletBloc = context.read<SetWalletBloc>();

    // Отримуємо потрібну змінну
    final walletTotal = walletBloc.state.totalUuid;

    return Scaffold(
      backgroundColor: kDarkBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GetWalletCubit, GetWalletState>(
            builder: (context, state) {
              // Ставимо Total на початок
              state.wallets.sort((a, b) {
                if (a.walletId == walletTotal) {
                  return -1; // a повинен бути першим
                } else if (b.walletId == walletTotal) {
                  return 1; // b повинен бути першим
                } else {
                  return 0; // залишити без змін
                }
              });

              if (state.wallets.isEmpty) {
                return const Center(
                  child: Text(
                    'No Wallets found',
                    style: TextStyle(color: Colors.amber),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return HorizontalSwipeList(wallets: state.wallets);
              }
            },
          )
        ],
      ),
    );
  }
}
