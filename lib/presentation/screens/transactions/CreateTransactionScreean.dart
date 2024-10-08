import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/TransactionFormCreate.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionScreean extends StatelessWidget {
  const CreateTransactionScreean({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String coinName = arguments?['nameCoin'] ?? 'Unknown Coin';
    final String coinSymbol = arguments?['symbol'] ?? 'Unknown Symbol';
    final int iconId = arguments?['iconId'] ?? 'Unknown Icon';
    // final double coinPrice = arguments?['coinPrice'] ?? 'Unknown Icon';

    return Scaffold(
      backgroundColor: kDarkBg,
      appBar: AppBar(
        title: Text(
          coinName,
          style: kAppBarStyle,
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
                TransactionFormCreate(
                  iconId: iconId,
                  coinName: coinName,
                  coinSymbol: coinSymbol,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
