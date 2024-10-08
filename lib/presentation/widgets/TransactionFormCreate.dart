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
  final int iconId;
  final String coinName;
  final String coinSymbol;

  const TransactionFormCreate({
    super.key,
    required this.iconId,
    required this.coinName,
    required this.coinSymbol,
  });

  @override
  _TransactionFormCreateState createState() => _TransactionFormCreateState();
}

class _TransactionFormCreateState extends State<TransactionFormCreate> {
  @override
  void initState() {
    super.initState();
    // Set Initial State
    context.read<TransactionBloc>().add(
          ResetState('', 0.0, 0.0, '', '', DateTime.now()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, transactionState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const TradeButtons(),
            const SizedBox(height: 10),
            BlocBuilder<GetWalletCubit, GetWalletState>(
              builder: (context, walletState) {
                return WalletsMenu(
                  transactionWalletId: transactionState.selectedWallet,
                  walletsList: walletState.wallets,
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
                    context
                        .read<TransactionBloc>()
                        .add(UpdateAmountValue(double.tryParse(value) ?? 0.0));
                  },
                ),
                const SizedBox(width: 10),
                NumberInput(
                  hintName: 'Price \$',
                  func: (value) {
                    context
                        .read<TransactionBloc>()
                        .add(UpdatePriceValue(double.tryParse(value) ?? 0.0));
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
              buttonColor: kConfirmColor,
              buttonText: 'Create Transaction',
              buttonTextStyle: kWidthButtonStyle,
              onPressed: () {
                //Set Icon, Name, Symbol
                context.read<TransactionBloc>().add(UpdateIcon(widget.iconId));
                context
                    .read<TransactionBloc>()
                    .add(UpdateName(widget.coinName));
                context
                    .read<TransactionBloc>()
                    .add(UpdateSymbol(widget.coinSymbol));
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
              },
            ),
          ],
        );
      },
    );
  }
}
