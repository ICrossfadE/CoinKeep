import 'package:CoinKeep/logic/bloc/transactions_bloc.dart';
import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({Key? key}) : super(key: key);

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  final TransactionsBloc _coinsBloc = TransactionsBloc();

  // @override
  // void initState() {
  //   // !
  //   _coinsBloc.add(GetCoins());
  //   super.initState();
  // } // ініціалізація завантаження даних при старті сторінки.

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
          _coinsBloc.add(SearchCoins(query: value));
          print('Input $value');
        },
      ),
    );
  }

  Widget _coins(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return _buildLoading();
        } else if (state is TransactionsLoaded) {
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
                      "ID: ${state.coinList.data![index].id}",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text("Name coin: ${state.coinList.data![index].name}",
                        style: TextStyle(color: Colors.black)),
                    Text("Symbol: ${state.coinList.data![index].symbol}",
                        style: TextStyle(color: Colors.black)),
                    Text(
                        "Price: ${state.coinList.data![index].quote?.uSD?.price}\$",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              );
            },
            // !
            itemCount: state.coinList.data?.length ?? 0,
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
