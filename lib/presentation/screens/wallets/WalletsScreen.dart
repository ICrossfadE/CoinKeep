import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
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
    return Scaffold(
      backgroundColor: kDarkBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GetWalletCubit, GetWalletState>(
            builder: (context, state) {
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
