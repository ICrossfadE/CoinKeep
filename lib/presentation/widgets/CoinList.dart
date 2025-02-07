import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/presentation/widgets/CardItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_animated/auto_animated.dart';

import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';

import '../../src/data/models/coin_model.dart';

class CoinList extends StatelessWidget {
  final String? walletTotalId;

  const CoinList({
    super.key,
    this.walletTotalId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalCacheBloc, LocalCacheState>(
      builder: (coinsContext, state) {
        if (state.status == CacheStatus.initial ||
            state.status == CacheStatus.loading) {
          return _buildLoading();
        }
        if (state.status == CacheStatus.success) {
          final coins = state.filteredCoins ?? [];
          // if (coins.isEmpty) {
          //   return const Center(child: Text('No Coins Found'));
          // }
          // // Створюємо список
          // return listOfCoins(context, coins);
          return coins.isEmpty
              ? const Center(child: Text('No Coins Found'))
              : listOfCoins(context, coins);
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget listOfCoins(BuildContext context, List<Data> coins) {
    return LiveList.options(
      options: const LiveOptions(
        delay: Duration.zero,
        showItemInterval: Duration(milliseconds: 50),
        showItemDuration: Duration(milliseconds: 300),
      ),
      itemCount: coins.length,
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: GestureDetector(
            // Кожна карточка списку
            child: CardItem(
              id: coins[index].id,
              coinName: coins[index].name,
              symbol: coins[index].symbol,
              price: coins[index].quote?.uSD?.price,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteId.createTransaction,
                arguments: {
                  'walletTotalId': walletTotalId,
                  'nameCoin': coins[index].name,
                  'symbol': coins[index].symbol,
                  'iconId': coins[index].id,
                  'coinPrice': coins[index].quote?.uSD?.price
                },
              );
            },
          ),
        );
      },
    );
  }
}
