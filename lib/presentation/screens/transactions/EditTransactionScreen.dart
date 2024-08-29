import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/TransactionFormEdit.dart';
import 'package:CoinKeep/src/constants/mainConstant.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String transactionId = arguments?['transactionId'] ?? 'Unknown UID';
    final int iconId = arguments?['iconId'] ?? 'Unknown Icon';
    final String coinName = arguments?['nameCoin'] ?? 'Unknown Coin';
    final String coinSymbol = arguments?['symbol'] ?? 'Unknown Symbol';
    final double coinPrice = arguments?['price'] ?? 'Unknown Price';
    final double coinAmount = arguments?['amount'] ?? 'Unknown Amount';
    final String coinTypeTraide = arguments?['type'] ?? 'Unknown typeTraide';
    final String coinWallet = arguments?['wallet'] ?? 'Unknown Wallet';
    final DateTime coinDate = arguments?['date'] ?? 'Unknown Date';

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
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return Padding(
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
                TransactionFormEdit(
                  transactionUid: transactionId,
                  initialIconId: iconId,
                  initialSymbol: coinSymbol,
                  initialPrice: coinPrice,
                  initialAmount: coinAmount,
                  initialTypeTraide: coinTypeTraide,
                  initialWallet: coinWallet,
                  initialDate: coinDate,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}