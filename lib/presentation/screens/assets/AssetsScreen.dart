import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/AssetCard.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BlocBuilder<AssetCubit, GetTransactionsState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Assets: ${state.assets.length}',
                    style: kSmallText,
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<AssetCubit, GetTransactionsState>(
                builder: (context, assetState) {
                  if (assetState.assets.isEmpty) {
                    return const Center(
                      child: Text(
                        'No transactions found.',
                        style: kSmallText,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: assetState.assets.length,
                    itemBuilder: (context, index) {
                      final asset = assetState.assets[index];
                      return BlocBuilder<LocalCacheBloc, LocalCacheState>(
                        builder: (context, cacheState) {
                          // Дістаєм елемент з кешу
                          final currentElement =
                              cacheState.coinModel!.data!.firstWhere(
                            (element) => element.id == asset.icon,
                          );
                          return GestureDetector(
                            child: AssetCard(
                              name: asset.name,
                              wallet: asset.wallet,
                              coinPrice: currentElement.quote!.uSD!.price,
                              currentPrice: asset.currentPrice,
                              totalCoins: asset.totalCoins,
                              profitPercent: asset.profitPercent,
                              profit: asset.profit,
                              icon: asset.icon,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                RouteId.assetDetails,
                                arguments: {
                                  'currentCoinPrice':
                                      currentElement.quote!.uSD!.price,
                                  'totalInvest': asset.totalInvest,
                                  'totalCoins': asset.totalCoins,
                                  'averagePrice': asset.averagePrice,
                                  'currentPrice': asset.currentPrice,
                                  'profitPercent': asset.profitPercent,
                                  'fixedProfit': asset.fixedProfit,
                                  'profit': asset.profit,
                                  'coinSymbol': asset.symbol,
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
