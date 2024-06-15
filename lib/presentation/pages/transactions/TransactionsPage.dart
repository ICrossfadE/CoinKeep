import 'package:CoinKeep/logic/blocs/local_cache_Bloc/local_cache_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext transactionContext) {
    return Scaffold(
      body: BlocProvider(
        // Передаємо _coinsBloc для дочірних елементів
        create: (transactionContext) => _coinsBloc,
        child: Column(
          children: [
            _searchField(),
            Expanded(
              child: _coins(transactionContext),
            ),
          ],
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
  Widget _coins(BuildContext coinsContext) {
    // Колірна схема
    final colorScheme = Theme.of(coinsContext).colorScheme;
    //Стиль для тексту
    const TextStyle textStyle = TextStyle(color: Colors.black);

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
              return Container(
                margin: const EdgeInsets.fromLTRB(1, 4, 1, 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                ),
                child: Column(
                  children: <Widget>[
                    Text("ID: ${coins[index].id}", style: textStyle),
                    Text("Name coin: ${coins[index].name}", style: textStyle),
                    Text("Symbol: ${coins[index].symbol}", style: textStyle),
                    Text("Price: ${coins[index].quote?.uSD?.price}\$",
                        style: textStyle),
                  ],
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
