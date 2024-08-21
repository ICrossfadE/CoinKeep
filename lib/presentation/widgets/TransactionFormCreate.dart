import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/DatePicker.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/SumFeild.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/TraideButtons.dart';
import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';
import 'package:CoinKeep/src/constants/mainConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/presentation/widgets/TransactionForm/WalletsMenu.dart';

import 'TransactionForm/InputNumber.dart';

class TransactionFormCreate extends StatelessWidget {
  final int iconId;
  final String coinSymbol;

  const TransactionFormCreate({
    super.key,
    required this.iconId,
    required this.coinSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const TradeButtons(),
            const SizedBox(height: 10),
            WalletsMenu(
              walletName: state.selectedWallet,
              onChanged: (value) {
                context.read<TransactionBloc>().add(UpdateWallet(
                    value)); // Passing 'value' as the positional argument
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                NumberInput(
                    hintName: 'Amount',
                    func: (value) {
                      context.read<TransactionBloc>().add(
                          UpdateAmountValue(double.tryParse(value) ?? 0.0));
                    }),
                const SizedBox(width: 10),
                NumberInput(
                    hintName: 'Price \$',
                    func: (value) {
                      context
                          .read<TransactionBloc>()
                          .add(UpdatePriceValue(double.tryParse(value) ?? 0.0));
                    })
              ],
            ),
            const SizedBox(height: 10),
            SumField(
              sumValue: state.sum,
            ),
            const SizedBox(height: 10),
            DatePicker(
              date: state.date,
              onChanged: (value) {
                context.read<TransactionBloc>().add(UpdateDate(value));
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kConfirmColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                context.read<TransactionBloc>().add(UpdateIcon(iconId));
                context.read<TransactionBloc>().add(UpdateSymbol(coinSymbol));
                context.read<TransactionBloc>().add(const Create());
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(RouteId.welcome),
                );
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
