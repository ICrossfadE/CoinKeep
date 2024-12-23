import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/DatePicker.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/SumFeild.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/TraideButtons.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/WalletsMenu.dart';

import 'TransactionForm/InputNumber.dart';

class TransactionFormCreate extends StatefulWidget {
  final int? iconId;
  final String? walletTotalId;
  final String coinName;
  final String coinSymbol;
  final double coinCurrentPrice;

  const TransactionFormCreate({
    super.key,
    this.walletTotalId,
    required this.iconId,
    required this.coinName,
    required this.coinSymbol,
    required this.coinCurrentPrice,
  });

  @override
  _TransactionFormCreateState createState() => _TransactionFormCreateState();
}

class _TransactionFormCreateState extends State<TransactionFormCreate> {
  bool _selectedTypeTraide = false;
  bool _addedAmount = false;

  @override
  void initState() {
    super.initState();
    // Set Initial State
    context.read<TransactionBloc>().add(
          ResetState('', 0.0, 0.0, '', '', DateTime.now()),
        );
  }

  void onUpdateTypeTraide(bool value) {
    setState(() {
      _selectedTypeTraide = value;
    });
  }

  void onUpdateAmount(bool value) {
    setState(() {
      _addedAmount = value;
    });
  }

  void _createTransaction() {
    if (_selectedTypeTraide && _addedAmount) {
      //Set Icon, Name, Symbol
      context.read<TransactionBloc>().add(UpdateIcon(widget.iconId));
      context.read<TransactionBloc>().add(UpdateName(widget.coinName));
      context.read<TransactionBloc>().add(UpdateSymbol(widget.coinSymbol));
      // Create
      context.read<TransactionBloc>().add(const Create());
      // Reset State
      context.read<TransactionBloc>().add(
            ResetState('', 0.0, 0.0, '', '', DateTime.now()),
          );

      Navigator.popUntil(
        context,
        ModalRoute.withName(RouteId.welcome),
      );

      onUpdateTypeTraide(false);
      onUpdateAmount(false);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, transactionState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TradeButtons(onUpdate: onUpdateTypeTraide),
            const SizedBox(height: 10),
            BlocBuilder<GetWalletCubit, GetWalletState>(
              builder: (context, walletState) {
                // Фільтруємо гаманці без Total Wallet
                final filteredWallets = walletState.wallets
                    .where(
                      (element) => element.walletId != widget.walletTotalId,
                    )
                    .toList();

                return WalletsMenu(
                  transactionWalletId: transactionState.selectedWallet,
                  walletsList: filteredWallets,
                  onChanged: (value) {
                    context.read<TransactionBloc>().add(UpdateWalletId(value));
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                NumberInput(
                  hintName: 'Amount',
                  func: (value) {
                    final parsedValue = double.tryParse(value) ?? 0.0;

                    context
                        .read<TransactionBloc>()
                        .add(UpdateAmountValue(parsedValue));

                    if (parsedValue > 0) {
                      onUpdateAmount(true);
                    } else {
                      onUpdateAmount(false);
                    }
                  },
                ),
                const SizedBox(width: 10),
                NumberInput(
                  hintName: 'Price \$',
                  func: (value) {
                    final parsedValue = double.tryParse(value) ?? 0.0;

                    context
                        .read<TransactionBloc>()
                        .add(UpdatePriceValue(parsedValue));
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            SumField(
              sumValue: transactionState.sum,
            ),
            const SizedBox(height: 10),
            DatePicker(
              selectedDate: transactionState.date,
              onChanged: (value) {
                context.read<TransactionBloc>().add(UpdateDate(value));
              },
            ),
            const SizedBox(height: 10),
            WidthButton(
              buttonColor: _selectedTypeTraide && _addedAmount
                  ? kConfirmColor.withAlpha(200)
                  : kDisabledConfirmColor.withAlpha(80),
              buttonText: 'Create Transaction',
              buttonTextStyle: _selectedTypeTraide && _addedAmount
                  ? kSmallText
                  : kSmallTextP,
              borderRadius: 10,
              buttonBorder: BorderSide(
                width: 2,
                color: Colors.white.withOpacity(0.2),
              ),
              onPressed: _createTransaction,
            ),
          ],
        );
      },
    );
  }
}
