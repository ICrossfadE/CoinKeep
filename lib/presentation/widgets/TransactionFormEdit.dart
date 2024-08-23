import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/DatePicker.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/SumFeild.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/TraideButtons.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/src/constants/mainConstant.dart';
import 'package:CoinKeep/src/utils/calculateAsset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/presentation/widgets/TransactionForm/WalletsMenu.dart';

import 'TransactionForm/InputNumber.dart';

class TransactionFormEdit extends StatelessWidget {
  final int initialIconId;
  final String initialSymbol;
  final double initialPrice;
  final double initialAmount;
  final String initialTypeTraide;
  final String initialWallet;
  final DateTime initialDate;

  const TransactionFormEdit({
    super.key,
    required this.initialIconId,
    required this.initialSymbol,
    required this.initialPrice,
    required this.initialAmount,
    required this.initialTypeTraide,
    required this.initialWallet,
    required this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    final CalculateTotal calculateTotal = CalculateTotal();

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TradeButtons(initialTypeTrade: initialTypeTraide),
            const SizedBox(height: 10),
            WalletsMenu(
              walletName: initialWallet,
              onChanged: (value) {
                context.read<TransactionBloc>().add(UpdateWallet(
                      value,
                    )); // Passing 'value' as the positional argument
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                NumberInput(
                    hintName: 'Amount',
                    initialValue: initialAmount.toString(),
                    func: (value) {
                      context.read<TransactionBloc>().add(
                          UpdateAmountValue(double.tryParse(value) ?? 0.0));
                    }),
                const SizedBox(width: 10),
                NumberInput(
                    hintName: 'Price \$',
                    initialValue: initialPrice.toString(),
                    func: (value) {
                      context
                          .read<TransactionBloc>()
                          .add(UpdatePriceValue(double.tryParse(value) ?? 0.0));
                    })
              ],
            ),
            const SizedBox(height: 10),
            SumField(
              initialSum: calculateTotal.totalSum(initialPrice, initialAmount),
              sumValue: state.sum,
            ),
            const SizedBox(height: 10),
            DatePicker(
              initialDate: initialDate,
              date: state.date,
              onChanged: (value) {
                context.read<TransactionBloc>().add(UpdateDate(value));
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kEditColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // context.read<TransactionBloc>().add(UpdateIcon(iconId));
                // context.read<TransactionBloc>().add(UpdateSymbol(coinSymbol));
                // context.read<TransactionBloc>().add(const Create());
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(RouteId.welcome),
                );
              },
              child: const Text(
                'Edit Transaction',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
