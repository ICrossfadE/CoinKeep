import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/assetForWallet_model.dart';
import 'package:CoinKeep/firebase/lib/src/models/infoForWallet_model.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/widgets/CoinChart.dart';
import 'package:CoinKeep/presentation/widgets/DefaultWallet.dart';
import 'package:CoinKeep/presentation/widgets/TotalWallet.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalSwipeList extends StatefulWidget {
  final List<WalletEntity> wallets;

  const HorizontalSwipeList({
    required this.wallets,
    super.key,
  });

  @override
  State<HorizontalSwipeList> createState() => _HorizontalSwipeListState();
}

class _HorizontalSwipeListState extends State<HorizontalSwipeList> {
  void _onFocusItem(int index) {
    return setState(() {
      widget.wallets[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Swiper(
          itemBuilder: _buildListItem,
          itemCount: widget.wallets.length,
          loop: false,
          onIndexChanged: (int index) {
            _onFocusItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final totalWalletId = context.read<SetWalletBloc>().state.totalUuid;

    return Column(
      children: [
        BlocBuilder<AssetCubit, GetTransactionsState>(
          builder: (context, assetState) {
            // Ключ до списку з данними
            final keyForItems = widget.wallets[index].walletId;
            final List<InfoForWalletModel>? items =
                assetState.infoForWallet[keyForItems];

            final InfoForWalletModel? item =
                items?.isNotEmpty == true ? items?.first : null;

            if (keyForItems == totalWalletId) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
                child: TotalWallet(
                  walletName: widget.wallets[index].walletName,
                  walletColor:
                      ColorUtils.hexToColor(widget.wallets[index].walletColor!),
                  infoVisible: true,
                  walletInvest: item?.totalWalletInvest,
                  walletProfitPercent: item?.currentTotalProfitPercent,
                  walletCurretProfitSum: item?.totalCurentProfitSum,
                  walletCurrentSum: item?.totalCurentSum,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
                child: DefaultWallet(
                  walletName: widget.wallets[index].walletName,
                  walletHeight: 250,
                  walletColor:
                      ColorUtils.hexToColor(widget.wallets[index].walletColor!),
                  walletStyle: kLargeText,
                  infoVisible: true,
                  walletInvest: item?.totalWalletInvest,
                  walletProfitPercent: item?.currentTotalProfitPercent,
                  walletCurretProfitSum: item?.totalCurentProfitSum,
                  walletCurrentSum: item?.totalCurentSum,
                ),
              );
            }
          },
        ),
        Expanded(
          child: BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
            builder: (context, transactionState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: BlocBuilder<AssetCubit, GetTransactionsState>(
                  builder: (context, assetState) {
                    // Ключ до списку з данними
                    final keyForItems = widget.wallets[index].walletId;
                    final List<AssetForWalletModel>? items = assetState
                        .assetsForWallet[keyForItems]
                        ?.where((item) => item.profitPercent != 0)
                        .toList();

                    // Якщо список порожній
                    if (items == null || items.isEmpty) {
                      return const Center(
                        child: Text(
                          'Empty',
                          style: kSmallText,
                        ),
                      );
                    }

                    return CoinChart(coins: items);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
