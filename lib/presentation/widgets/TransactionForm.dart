import 'package:CoinKeep/presentation/widgets/TransactionForm/DatePicker.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/TraideButtons.dart';
import 'package:CoinKeep/logic/blocs/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/presentation/widgets/TransactionForm/WalletsMenu.dart';

import 'TransactionForm/InputNumber.dart';

class TransactionForm extends StatelessWidget {
  final int iconId;
  final String coinSymbol;

  const TransactionForm({
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
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                context.read<TransactionBloc>().add(const Submit());
                Navigator.pop(context);
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