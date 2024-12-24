import 'dart:ui';

import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/assetForWallet_model.dart';
import 'package:CoinKeep/firebase/lib/src/models/infoForWallet_model.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/widgets/CoinChart.dart';
import 'package:CoinKeep/presentation/widgets/DefaultWallet.dart';
import 'package:CoinKeep/presentation/widgets/TotalWallet.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
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
  double _opacity = 0.0;
  int selectedWallet = 0;
  int _pendingIndex =
      -1; // Для збереження індексу, який очікує завершення анімації.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  void _onFocusItem(int index) {
    // Якщо індекс вже очікує завершення, не запускаємо нову логіку.
    if (_pendingIndex == index) return;

    setState(() {
      _opacity = 0.0;
      _pendingIndex = index; // індекс очікує завершення.
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _pendingIndex == index) {
        setState(() {
          selectedWallet = index;
          _opacity = 1.0;
          _pendingIndex = -1; // Скидаємо очікування індексу.
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetCubit, GetTransactionsState>(
      builder: (context, assetState) {
        // Ключ до списку з данними
        final keyForItems = widget.wallets[selectedWallet].walletId;
        final List<InfoForWalletModel>? items =
            assetState.infoForWallet[keyForItems];

        final InfoForWalletModel? item =
            items?.isNotEmpty == true ? items?.first : null;

        return Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 2), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Align(
                alignment: const AlignmentDirectional(4, -1.6),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (item?.currentTotalProfitPercent ?? 0) == 0
                        ? kDarkBg
                        : (item?.currentTotalProfitPercent ?? 0) > 0
                            ? kConfirmColor.withOpacity(0.5)
                            : kCancelColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 2), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Align(
                alignment: const AlignmentDirectional(-5.5, 1.5),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (item?.currentTotalProfitPercent ?? 0) == 0
                        ? kDarkBg
                        : (item?.currentTotalProfitPercent ?? 0) > 0
                            ? kConfirmColor.withOpacity(0.5)
                            : kCancelColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 2), // Тривалість анімації
              opacity: _opacity,
              curve: Curves.easeInOut, // Крива анімації
              child: Align(
                alignment: const AlignmentDirectional(1, 0.6),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (item?.currentTotalProfitPercent ?? 0) == 0
                        ? kDarkBg
                        : (item?.currentTotalProfitPercent ?? 0) > 0
                            ? kConfirmColor.withOpacity(0.5)
                            : kCancelColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Swiper(
                itemBuilder: _buildListItem,
                itemCount: widget.wallets.length,
                pagination: const SwiperPagination(
                  builder: SwiperPagination.dots,
                  margin: EdgeInsets.only(bottom: 460),
                ),
                loop: false,
                onIndexChanged: (int index) {
                  _onFocusItem(index);
                },
              ),
            ),
          ],
        );
      },
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
