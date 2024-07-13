import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/pages/transactions/widgets/PurchaseForm.dart';

import '../transactionCanstants.dart';

// Ініціалізація - LocalCacheBloc
final LocalCacheBloc _coinsBloc = LocalCacheBloc();

class CoinListWidget extends StatelessWidget {
  const CoinListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                            Text("Name coin: ${coins[index].name}",
                                style: coinStyle),
                            Text("Symbol: ${coins[index].symbol}",
                                style: coinStyle),
                            Text(
                                "Price: ${(coins[index].quote?.uSD?.price ?? 0).toStringAsFixed(6)}\$",
                                style: coinStyle),
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
                        height: 600,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.network(
                                  'https://s2.coinmarketcap.com/static/img/coins/64x64/${coins[index].id}.png',
                                  width: 64,
                                  height: 64,
                                ),
                                Text('${coins[index].symbol}'),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('BUY'),
                                      Text('SELL'),
                                    ],
                                  ),
                                ),
                                const PurchaseForm(),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
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
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
