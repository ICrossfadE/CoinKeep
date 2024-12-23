import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/presentation/widgets/HorizontalSwipeList.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletsScreen extends StatelessWidget {
  const WalletsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWalletCubit, GetWalletState>(
      builder: (context, state) {
        final List<WalletEntity> walletList;

        if (state.wallets.length > 1) {
          // Обєднуєм гаманці
          walletList = [...state.totalWallet, ...state.wallets];
        } else {
          // Передаємо гаманці з firebase гаманці
          walletList = state.wallets;
        }

        if (state.wallets.isEmpty) {
          return const Center(
            child: Text(
              'No Wallets found',
              style: kSmallText,
            ),
          );
        } else {
          return HorizontalSwipeList(wallets: walletList);
        }
      },
    );
  }
}
