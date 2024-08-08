import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/widgets/PurchaseForm.dart';
import 'package:CoinKeep/presentation/widgets/TraideButtons.dart';
import 'package:CoinKeep/presentation/widgets/WallletsMenu.dart';

import '../../src/data/models/coin_model.dart';
import '../../src/constants/transactionCanstants.dart';

class CoinListWidget extends StatelessWidget {
  const CoinListWidget({super.key});

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
          if (coins.isEmpty) {
            return const Center(child: Text('No Coins Found'));
          }
          // Створюємо список
          return listOfCoins(context, coins);
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget listOfCoins(BuildContext context, List<Data> coins) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      itemBuilder: (coinsContext, index) {
        return GestureDetector(
          // Кожна карточка списку
          child: Card(
            color: colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://s2.coinmarketcap.com/static/img/coins/64x64/${coins[index].id}.png',
                    width: 64,
                    height: 64,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("ID: ${coins[index].id}", style: coinStyle),
                      Text("Name coin: ${coins[index].name}", style: coinStyle),
                      Text("Symbol: ${coins[index].symbol}", style: coinStyle),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 700,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.network(
                            'https://s2.coinmarketcap.com/static/img/coins/64x64/${coins[index].id}.png',
                            width: 54,
                            height: 54,
                          ),
                          const SizedBox(height: 10),
                          Text('${coins[index].symbol}'),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: TraideButtons(),
                          ),
                          const WallletsMenu(),
                          const SizedBox(height: 10),
                          const PurchaseForm(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      itemCount: coins.length,
    );
  }
}