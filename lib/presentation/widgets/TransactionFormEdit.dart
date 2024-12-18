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
import 'package:CoinKeep/src/utils/calculateAsset.dart';

import 'TransactionForm/InputNumber.dart';

class TransactionFormEdit extends StatefulWidget {
  final String? walletTotalId;
  final String transactionUid;
  final int initialIconId;
  final String initialSymbol;
  final double initialPrice;
  final double initialAmount;
  final String initialTypeTraide;
  final String initialWalletId;
  final DateTime initialDate;

  const TransactionFormEdit({
    super.key,
    this.walletTotalId,
    required this.transactionUid,
    required this.initialIconId,
    required this.initialSymbol,
    required this.initialPrice,
    required this.initialAmount,
    required this.initialTypeTraide,
    required this.initialWalletId,
    required this.initialDate,
  });

  @override
  _TransactionFormEditState createState() => _TransactionFormEditState();
}

class _TransactionFormEditState extends State<TransactionFormEdit> {
  bool _addedAmount = true;

  @override
  void initState() {
    super.initState();
    // Set Initial State
    context.read<TransactionBloc>().add(
          ResetState(
            '',
            widget.initialAmount,
            widget.initialPrice,
            widget.initialTypeTraide,
            widget.initialWalletId,
            widget.initialDate,
          ),
        );
  }

  void onUpdateAmount(bool value) {
    setState(() {
      _addedAmount = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CalculateTotal calculateTotal = CalculateTotal();

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, transactionState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TradeButtons(initialTypeTrade: widget.initialTypeTraide),
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
                  walletsList: filteredWallets,
                  transactionWalletId: widget.initialWalletId,
                  isEditMode: true,
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
                    initialValue: widget.initialAmount.toString(),
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
                    }),
                const SizedBox(width: 10),
                NumberInput(
                  hintName: 'Price \$',
                  initialValue: widget.initialPrice.toString(),
                  func: (value) {
                    context
                        .read<TransactionBloc>()
                        .add(UpdatePriceValue(double.tryParse(value) ?? 0.0));
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            SumField(
              initialSum: calculateTotal.totalSum(
                  widget.initialPrice, widget.initialAmount),
              sumValue: transactionState.sum,
            ),
            const SizedBox(height: 10),
            DatePicker(
              initialDate: widget.initialDate,
              selectedDate: transactionState.date,
              onChanged: (value) {
                context.read<TransactionBloc>().add(UpdateDate(value));
              },
            ),
            const SizedBox(height: 10),
            WidthButton(
                buttonColor: _addedAmount
                    ? kEditColor.withAlpha(200)
                    : kDisabledEditColor.withAlpha(80),
                buttonText: 'Edit Transaction',
                buttonTextStyle: _addedAmount ? kSmallText : kSmallTextP,
                borderRadius: 10,
                buttonBorder: BorderSide(
                  width: 2,
                  color: Colors.white.withOpacity(0.2),
                ),
                onPressed: () {
                  if (_addedAmount) {
                    context.read<TransactionBloc>().add(
                          Update(
                            transactionId: widget.transactionUid,
                            newWalletId: transactionState.selectedWallet,
                            newTypeTrade: transactionState.typeTrade,
                            newPrice: transactionState.price,
                            newAmount: transactionState.amount,
                            newDate: transactionState.date,
                          ),
                        );
                    // Reset State
                    context.read<TransactionBloc>().add(
                          ResetState('', 0.0, 0.0, '', '', DateTime.now()),
                        );
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(RouteId.welcome),
                    );
                    onUpdateAmount(false);
                  } else {
                    return;
                  }
                }),
          ],
        );
      },
    );
  }
}
