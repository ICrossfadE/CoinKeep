import 'package:CoinKeep/logic/bloc/local_cache/local_cache_bloc.dart';
import 'package:CoinKeep/logic/bloc/transactions/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({Key? key}) : super(key: key);

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  final LocalCacheBloc _coinsBloc = LocalCacheBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _coinsBloc,
        child: Column(
          children: [
            _searchField(),
            Expanded(
              child: _coins(context),
            ),
          ],
        ),
      ),
    );
  }

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
          _coinsBloc.add(SearchCoinsByName(value));
        },
      ),
    );
  }

  Widget _coins(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LocalCacheBloc, LocalCacheState>(
      builder: (context, state) {
        if (state.status == CacheStatus.initial ||
            state.status == CacheStatus.loading) {
          return _buildLoading();
        }
        if (state.status == CacheStatus.success) {
          final coins = state.filteredCoins ?? [];
          if (coins.isEmpty) {
            return const Center(child: Text('No Coins Found'));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(1, 4, 1, 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "ID: ${coins[index].id}",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text("Name coin: ${coins[index].name}",
                        style: TextStyle(color: Colors.black)),
                    Text("Symbol: ${coins[index].symbol}",
                        style: TextStyle(color: Colors.black)),
                    Text("Price: ${coins[index].quote?.uSD?.price}\$",
                        style: TextStyle(color: Colors.black)),
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
