import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/presentation/widgets/AssetTitleInfo.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';

class DetailsAssetScreen extends StatelessWidget {
  const DetailsAssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Отримання параметрів з аргументів
    final String coinSymbol = arguments?['coinSymbol'] ?? '';
    final double totalInvest = arguments?['totalInvest'] ?? 0.0;
    final double totalCoins = arguments?['totalCoins'] ?? 0.0;
    final double averagePrice = arguments?['averagePrice'] ?? 0.0;
    final double currentPrice = arguments?['currentPrice'] ?? 0.0;
    final double profitPercent = arguments?['profitPercent'] ?? 0.0;
    final double fixedProfit = arguments?['fixedProfit'] ?? 0.0;
    final double profit = arguments?['profit'] ?? 0.0;

    // Визначення стилів тексту на основі значень
    TextStyle balanceStyle = totalCoins == 0 ? kAssetTitle : kAssetTitleGreen;
    TextStyle investStyle = totalInvest == 0 ? kAssetTitle : kAssetTitleFocus;
    TextStyle profitStyle = profit > 0 ? kAssetTitleGreen : kAssetTitleRed;
    TextStyle profitPercentStyle = profitPercent == 0
        ? kAssetTitle
        : (profitPercent > 0 ? kAssetTitleGreen : kAssetTitleRed);
    TextStyle profitFixedStyle = fixedProfit == 0
        ? kAssetTitle
        : (profitPercent > 0 ? kAssetTitleGreen : kAssetTitleRed);

    // Отримання стану гаманців
    final walletState = context.watch<GetWalletCubit>().state;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: AssetTitleInfo(
                          title: 'Balance COINS',
                          value: totalCoins.toStringAsFixed(2),
                          aligmeent: MainAxisAlignment.center,
                          symbol: coinSymbol,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AssetTitleInfo(
                          title: 'Balance USD',
                          value: '${currentPrice.toStringAsFixed(2)}\$',
                          aligmeent: MainAxisAlignment.center,
                          specialStyle: balanceStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: AssetTitleInfo(
                          title: 'Average price',
                          value: '${averagePrice.toStringAsFixed(2)}\$',
                          aligmeent: MainAxisAlignment.center,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AssetTitleInfo(
                          title: 'Total Invest',
                          value: '${totalInvest.toStringAsFixed(2)}\$',
                          aligmeent: MainAxisAlignment.center,
                          specialStyle: investStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: AssetTitleInfo(
                          title: 'Profit Percent',
                          value: '${profitPercent.toStringAsFixed(2)}%',
                          aligmeent: MainAxisAlignment.center,
                          specialStyle: profitPercentStyle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AssetTitleInfo(
                          title: 'Profit',
                          value: '${profit.toStringAsFixed(2)}\$',
                          aligmeent: MainAxisAlignment.center,
                          specialStyle: profitStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AssetTitleInfo(
                    title: 'Fixed Profit',
                    value: '${fixedProfit.toStringAsFixed(2)}\$',
                    aligmeent: MainAxisAlignment.center,
                    specialStyle: profitFixedStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
                builder: (context, transactionsState) {
                  // Фільтруємо транзакції за символом монети
                  final transactionsList = transactionsState.transactions
                      .where((transaction) => transaction.symbol == coinSymbol)
                      .toList();

                  if (transactionsList.isEmpty) {
                    return const Center(child: Text('No transactions found.'));
                  }

                  return ListView.builder(
                    itemCount: transactionsList.length,
                    itemBuilder: (context, index) {
                      final transaction = transactionsList[index];

                      // Доступ до стану гаманця тут
                      final WalletEntity? wallet =
                          walletState.wallets.firstWhere(
                        (wallet) => wallet.walletId == transaction.walletId,
                        orElse: () => WalletEntity(
                          walletId: null,
                          walletName: 'Not installed wallet',
                        ),
                      );

                      return Dismissible(
                        key: ValueKey(transaction.id),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${transaction.symbol} Deleted'),
                              ),
                            );
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
                            return Future.value(false);
                          } else if (direction == DismissDirection.endToStart) {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: kDark500,
                                  title: const Text('Confirm',
                                      style: TextStyle(color: Colors.white)),
                                  content: const Text(
                                      'Are you sure you want to remove this item?',
                                      style: TextStyle(color: Colors.white)),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(true); // Підтвердити видалення
                                      },
                                      child: const Text("Delete",
                                          style:
                                              TextStyle(color: kCancelColor)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(false); // Скасувати видалення
                                      },
                                      child: const Text("Cancel",
                                          style:
                                              TextStyle(color: kDefaultlColor)),
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
                          gradientBeginAligment: Alignment.centerRight,
                          gradientEndAligment: Alignment.centerLeft,
                          icon: Icons.edit,
                          textButton: 'Edit',
                        ),
                        secondaryBackground: const DismisibleButton(
                          color: kCancelColor,
                          aligment: Alignment.centerRight,
                          gradientBeginAligment: Alignment.centerLeft,
                          gradientEndAligment: Alignment.centerRight,
                          icon: Icons.delete,
                          textButton: 'Delete',
                        ),
                        child: TransactionCard(
                          wallet: wallet?.walletName,
                          walletColor: ColorUtils.hexToColor(
                              wallet?.walletColor ?? '#FF757575'),
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
      ),
    );
  }
}
