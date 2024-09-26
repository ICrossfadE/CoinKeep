import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
// import 'package:CoinKeep/src/data/models/coin_model.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';

class DetailsAssetScreen extends StatelessWidget {
  const DetailsAssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final List<TransactionEntity> transactionsList =
        arguments?['transactionList'] ?? [];
    final String coinSymbol = arguments?['coinSymbol'] ?? '';
    final double totalInvest = arguments?['totalInvest'] ?? 0.0;
    final double totalCoins = arguments?['totalCoins'] ?? 0.0;
    final double averagePrice = arguments?['averagePrice'] ?? 0.0;
    final double currentPrice = arguments?['currentPrice'] ?? 0.0;
    final double profitPercent = arguments?['profitPercent'] ?? 0.0;
    final double fixedProfit = arguments?['fixedProfit'] ?? 0.0;
    final double profit = arguments?['profit'] ?? 0.0;

    return Scaffold(
      backgroundColor: kDarkBg,
      appBar: AppBar(
        title: const Text(
          'Transaction Details',
          style: kAppBarStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: kDark500,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance: ${totalCoins.toStringAsFixed(2)} $coinSymbol',
                      style: kAssetTitle,
                    ),
                    Text(
                      // B
                      '${currentPrice.toStringAsFixed(2)}\$',
                      style: kAssetTitle,
                    ),
                  ],
                ),
                Text(
                  'Total Invest: ${totalInvest.toStringAsFixed(2)}\$',
                  style: kAssetTitle,
                ),
                Text(
                  'Average price: ${averagePrice.toStringAsFixed(2)}\$',
                  style: kAssetTitle,
                ),
                Text(
                  'Profit Percent: ${profitPercent.toStringAsFixed(2)}\$',
                  style: kAssetTitle,
                ),
                Text(
                  'Profit: ${profit.toStringAsFixed(2)}\$',
                  style: kAssetTitle,
                ),
                Text(
                  'Fixed Profit: ${fixedProfit.toStringAsFixed(2)}\$',
                  style: kAssetTitle,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GetWalletCubit, GetWalletState>(
              builder: (context, walletState) {
                return ListView.builder(
                  itemCount: transactionsList.length,
                  itemBuilder: (context, index) {
                    final transaction = transactionsList[index];

                    // Перевіряємо, чи знайдено гаманець
                    final WalletEntity? wallet = walletState.wallets.firstWhere(
                      (wallet) => wallet.walletId == transaction.walletId,
                      // Для тих транзакції в яких walletId = null
                      orElse: () => WalletEntity(
                        walletId: null,
                        walletName: 'Not installed wallet',
                      ),
                    );

                    return Dismissible(
                      key: ValueKey(transaction.id),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          context
                              .read<TransactionBloc>()
                              .add(Delete(transaction.id));
                        }
                      },
                      confirmDismiss: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          Navigator.of(context).pushNamed(
                            RouteId.editTransaction,
                            arguments: {
                              'transactionId': transaction.id,
                              'iconId': transaction.icon,
                              'nameCoin': transaction.symbol,
                              'symbol': transaction.symbol,
                              'price': transaction.price,
                              'amount': transaction.amount,
                              'type': transaction.type,
                              'wallet': transaction.walletId,
                              'date': transaction.date,
                            },
                          );
                          // Повернення `false` запобігає зникненню елемента
                          return Future.value(false);
                        } else if (direction == DismissDirection.endToStart) {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: kDark500,
                                title: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Are you sure you want to remove this item?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(true); // Підтвердити видалення
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: kCancelColor),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(false); // Скасувати видалення
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: kDefaultlColor),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return Future.value(false);
                      },
                      background: const DismisibleButton(
                        color: kEditColor,
                        aligment: Alignment.centerLeft,
                        icon: Icons.edit,
                        textButton: 'Edit',
                      ),
                      secondaryBackground: const DismisibleButton(
                        color: kCancelColor,
                        aligment: Alignment.centerRight,
                        icon: Icons.delete,
                        textButton: 'Delete',
                      ),
                      child: TransactionCard(
                        wallet: wallet?.walletName,
                        type: transaction.type,
                        icon: transaction.icon,
                        symbol: transaction.symbol,
                        name: transaction.name,
                        amount: transaction.amount,
                        price: transaction.price,
                        date: transaction.date,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
