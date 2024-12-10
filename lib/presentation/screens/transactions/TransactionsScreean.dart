// import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/presentation/widgets/DismisibleButton.dart';
import 'package:CoinKeep/presentation/widgets/TransactionCard.dart';

import '../../../logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import '../../../src/constants/textStyle.dart';
import '../../routes/routes.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Отримуємо Блок
    final walletBloc = context.read<SetWalletBloc>();

    // // // Отримуємо потрібну змінну
    final walletTotal = walletBloc.state.totalUuid;

    return Scaffold(
      backgroundColor: kDarkBg,
      body: Column(
        children: [
          BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total transactions: ${state.transactions.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
              builder: (context, transactionState) {
                if (transactionState.transactions.isEmpty) {
                  return const Center(child: Text('No transactions found.'));
                }
                return BlocBuilder<GetWalletCubit, GetWalletState>(
                    builder: (context, walletState) {
                  return ListView.builder(
                    itemCount: transactionState.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactionState.transactions[index];

                      // Перевіряємо, чи знайдено гаманець
                      final WalletEntity wallet =
                          walletState.wallets.firstWhere(
                        (wallet) => wallet.walletId == transaction.walletId,
                        // Для тих транзакції в яких walletId = null
                        orElse: () => WalletEntity(
                          walletId: null,
                          walletName: 'Not installed wallet',
                        ),
                      );

                      return BlocBuilder<LocalCacheBloc, LocalCacheState>(
                        builder: (context, state) {
                          // Дістаєм елемент з кешу
                          final currentElement =
                              state.coinModel!.data!.firstWhere(
                            (element) => element.id == transaction.icon,
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Dismissible(
                              key: ValueKey(transaction.id),
                              onDismissed: (direction) {
                                // Delete
                                if (direction == DismissDirection.endToStart) {
                                  context
                                      .read<TransactionBloc>()
                                      .add(DeleteTransaction(transaction.id));
                                }
                              },
                              confirmDismiss: (direction) {
                                // EdiT
                                if (direction == DismissDirection.startToEnd) {
                                  Navigator.of(context).pushNamed(
                                    RouteId.editTransaction,
                                    arguments: {
                                      'walletTootalId': walletTotal,
                                      'transactionId': transaction.id,
                                      'currentCoinPrice':
                                          currentElement.quote!.uSD!.price,
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
                                } else if (direction ==
                                    DismissDirection.endToStart) {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return _alertWidget(context);
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
                                wallet: wallet.walletName,
                                walletColor: ColorUtils.hexToColor(
                                    wallet.walletColor ?? '#FF757575'),
                                type: transaction.type,
                                icon: transaction.icon,
                                symbol: transaction.symbol,
                                name: transaction.name,
                                amount: transaction.amount,
                                price: transaction.price,
                                date: transaction.date,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                });
              },
            ),
          ),
          WidthButton(
            buttonColor: kConfirmColor,
            buttonText: 'New Transaction',
            buttonTextStyle: kWidthButtonStyle,
            blurRadius: 50,
            spreadRadius: 30,
            buttonIcon: Icons.add,
            onPressed: () {
              Navigator.of(context).pushNamed(RouteId.searchCoins);
            },
          ),
        ],
      ),
    );
  }

  Widget _alertWidget(BuildContext context) {
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
            Navigator.of(context).pop(true); // Підтвердити видалення
          },
          child: const Text(
            "Delete",
            style: TextStyle(color: kCancelColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Скасувати видалення
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: kDefaultlColor),
          ),
        ),
      ],
    );
  }
}
