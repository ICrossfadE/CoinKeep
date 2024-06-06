import 'package:CoinKeep/blocs/transactions/transactions_bloc.dart';
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

  @override
  void initState() {
    // !
    _coinsBloc.add(GetCoins());
    super.initState();
  } // ініціалізація завантаження даних при старті сторінки.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          print('create Transactions'),
        },
        child: const Icon(Icons.get_app),
      ),
      body: _buildListCoins(),
    );
  }

  Widget _buildListCoins() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        // !
        child: BlocProvider(
          create: (context) => _coinsBloc,
          // BlocBuilder для прослуховування змін стану BLoC і оновлення UI відповідно.
          // !
          child: BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsInitial) {
                return _buildLoading();
              } else if (state is TransactionsLoading) {
                return _buildLoading();
              } else if (state is TransactionsLoaded) {
                return _buildCard(context, state.coinModel);
              } else if (state is TransactionsError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CoinModel model) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: model.data!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "ID: ${model.data![index].id}",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("Name coin: ${model.data![index].name}",
                      style: TextStyle(color: Colors.black)),
                  Text("Symbol: ${model.data![index].symbol}",
                      style: TextStyle(color: Colors.black)),
                  Text("Price: ${model.data![index].quote?.uSD?.price}\$",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
