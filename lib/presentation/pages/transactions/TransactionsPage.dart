import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transactionCanstants.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  // Ініціалізація - LocalCacheBloc
  final LocalCacheBloc _coinsBloc = LocalCacheBloc();

  @override
  //Головний інтерфейс
  Widget build(BuildContext context) {
    final fullScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        // Передаємо _coinsBloc для дочірних елементів
        create: (transactionContext) => _coinsBloc,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add transaction');
        },
        backgroundColor: backgroundColor,
        child: const Icon(Icons.add),
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
    // Колірна схема
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
              return Card(
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
