import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/presentation/widgets/HorizontalSwipeList.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({super.key});

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWalletCubit, GetWalletState>(
      builder: (context, state) {
        final List<WalletEntity> walletList;

        if (state.wallets.length > 1) {
          walletList = [...state.totalWallet, ...state.wallets];
        } else {
          walletList = state.wallets;
        }

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _visible ? 1.0 : 0.0,
          child: state.wallets.isEmpty
              ? const Center(
                  child: Text(
                    'No Wallets found',
                    style: kSmallText,
                  ),
                )
              : HorizontalSwipeList(wallets: walletList),
        );
      },
    );
  }
}
