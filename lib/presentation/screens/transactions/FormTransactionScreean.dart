import 'package:CoinKeep/logic/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../src/constants/mainConstant.dart';

class FormTransactionScreean extends StatelessWidget {
  const FormTransactionScreean({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String coinName = arguments?['nameCoin'] ?? 'Unknown Coin';
    final String coinSymbol = arguments?['symbol'] ?? 'Unknown Symbol';
    final int iconId = arguments?['iconId'] ?? 'Unknown Icon';
    // final double coinPrice = arguments?['coinPrice'] ?? 'Unknown Icon';
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          coinName,
          style: kAppBarStyle,
          textAlign: TextAlign.center,
        ),
        backgroundColor: colorScheme.secondary,
        iconTheme: kAppBarIconStyle,
      ),
      body: BlocProvider(
        create: (context) => TransactionBloc(
          FirebaseAuth.instance,
          coinSymbol,
          iconId,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: 'coinLogo-$iconId',
                child: Image.network(
                  'https://s2.coinmarketcap.com/static/img/coins/64x64/$iconId.png',
                  width: 64,
                  height: 64,
                ),
              ),
              Center(
                child: Text(coinSymbol),
              ),
              TransactionForm(
                iconId: iconId,
                coinSymbol: coinSymbol,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
