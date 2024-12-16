import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/TransactionFormEdit.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String walletTotal = arguments?['walletTootalId'] ?? '';
    final String transactionId = arguments?['transactionId'] ?? 'Unknown UID';
    final double currentCoinPrice = arguments?['currentCoinPrice'] ?? 0.00;
    final int iconId = arguments?['iconId'] ?? 'Unknown Icon';
    final String coinName = arguments?['nameCoin'] ?? 'Unknown Coin';
    final String coinSymbol = arguments?['symbol'] ?? 'Unknown Symbol';
    final double coinPrice = arguments?['price'] ?? 0.00;
    final double coinAmount = arguments?['amount'] ?? 0.00;
    final String coinTypeTraide = arguments?['type'] ?? 'Unknown typeTraide';
    final String coinWalletId = arguments?['wallet'] ?? 'Unknown Wallet';
    final DateTime coinDate = arguments?['date'] ?? 'Unknown Date';

    return Scaffold(
      backgroundColor: kDarkBg,
      appBar: AppBar(
        title: Text(
          'Edit transaction: $coinName',
          style: kMediumText,
          textAlign: TextAlign.center,
        ),
        backgroundColor: kDark500,
        iconTheme: const IconThemeData(
          color: Colors.white, // Колір кнопки назад
        ),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  child: Text(
                    coinSymbol,
                    style: kSmallText,
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white12,
                    ),
                    child: Text(
                      currentCoinPrice < 1
                          ? '${currentCoinPrice.toStringAsFixed(4)}\$'
                          : '${currentCoinPrice.toStringAsFixed(2)}\$',
                      style: kSmallText,
                    ),
                  ),
                ),
                TransactionFormEdit(
                  walletTotalId: walletTotal,
                  transactionUid: transactionId,
                  initialIconId: iconId,
                  initialSymbol: coinSymbol,
                  initialPrice: coinPrice,
                  initialAmount: coinAmount,
                  initialTypeTraide: coinTypeTraide,
                  initialWalletId: coinWalletId,
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
