import 'package:CoinKeep/presentation/pages/dashboard/dashboardConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'transactionCanstants.dart';

// Ініціалізація - LocalCacheBloc
final LocalCacheBloc _coinsBloc = LocalCacheBloc();

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  @override
  Widget build(BuildContext context) {
    final fullScreenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Transactions',
          style: appBarStyle,
        ),
        backgroundColor: colorScheme.secondary,
      ),
      body: BlocProvider(
        // Передаємо _coinsBloc для дочірних елементів
        create: (transactionContext) => _coinsBloc,
        child: SafeArea(
          child: SizedBox(
            height: fullScreenHeight,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      _searchField(),
                      Expanded(
                        child: _coins(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Пошукова панель
  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: 'Search coins...',
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: (value) {
          //Додавання події SearchCoinsByName
          _coinsBloc.add(SearchCoinsByName(value));
        },
      ),
    );
  }

  //Кожна карточка
  Widget _coins(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Слідкування за станом LocalCacheState
    return BlocBuilder<LocalCacheBloc, LocalCacheState>(
      builder: (coinsContext, state) {
        if (state.status == CacheStatus.initial ||
            state.status == CacheStatus.loading) {
          return _buildLoading();
        }
        if (state.status == CacheStatus.success) {
          //Перевірка чи масив не null якщо null присвоїти []
          final coins = state.filteredCoins ?? [];
          if (coins.isEmpty) {
            return const Center(child: Text('No Coins Found'));
          }
          //Список елементів
          return ListView.builder(
            itemBuilder: (coinsContext, index) {
              return GestureDetector(
                child: Card(
                  color: colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://s2.coinmarketcap.com/static/img/coins/64x64/${coins[index].id}.png',
                          width: 64, // встановіть бажаний розмір
                          height: 64,
                        ),
                        Column(
                          children: <Widget>[
                            Text("ID: ${coins[index].id}", style: coinStyle),
                            Text("Name coin: ${coins[index].name}",
                                style: coinStyle),
                            Text("Symbol: ${coins[index].symbol}",
                                style: coinStyle),
                            Text("Price: ${coins[index].quote?.uSD?.price}\$",
                                style: coinStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print('${coins[index].name}');
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

  //Віджет спінер загрузки
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
