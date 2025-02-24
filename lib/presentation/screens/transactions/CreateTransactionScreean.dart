import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/TransactionFormCreate.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CoinKeep/firebase/lib/src/models/asset_model.dart';

class CreateTransactionScreean extends StatelessWidget {
  const CreateTransactionScreean({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String walletTotalId = arguments?['walletTotalId'] ?? '';
    final String coinName = arguments?['nameCoin'] ?? 'Unknown Coin';
    final String coinSymbol = arguments?['symbol'] ?? 'Unknown Symbol';
    final int? iconId = arguments?['iconId'];
    final double coinPrice = arguments?['coinPrice'] ?? 'Unknown Icon';

    Widget getIcon() {
      if (iconId != null) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/$iconId.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover, // Забезпечує повне заповнення області
            ),
          ),
        );
      } else {
        return const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image(
              image: AssetImage('assets/dollar.png'),
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              coinName,
              style: kMediumText.copyWith(color: Colors.white),
            ),
            BlocBuilder<AssetCubit, GetTransactionsState>(
              builder: (context, assetState) {
                final asset = assetState.assets.firstWhere(
                  (element) => element.symbol == coinSymbol,
                  orElse: () => AssetModel(
                    symbol: '',
                    name: '',
                    wallet: '',
                    totalInvest: 0,
                    totalCoins: 0,
                    averagePrice: 0,
                    currentPrice: 0,
                    profitPercent: 0,
                    fixedProfit: 0,
                    profit: 0,
                    icon: 0,
                  ),
                );
                return Column(
                  children: [
                    const Text(
                      'Current total coins',
                      style: kTextP,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white12,
                      ),
                      child: Text(
                        '${asset.totalCoins?.toStringAsFixed(4)}',
                        style: kSmallText,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                Hero(tag: 'coinLogo-$iconId', child: getIcon()),
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
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(
                      coinPrice < 1
                          ? '${coinPrice.toStringAsFixed(7)}\$'
                          : '${coinPrice.toStringAsFixed(2)}\$',
                      style: kSmallText,
                    ),
                  ),
                ),
                TransactionFormCreate(
                  walletTotalId: walletTotalId,
                  iconId: iconId,
                  coinName: coinName,
                  coinSymbol: coinSymbol,
                  coinCurrentPrice: coinPrice,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
