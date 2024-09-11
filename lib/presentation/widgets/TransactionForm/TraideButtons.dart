import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/logic/blocs/setTransaction_bloc/transaction_bloc.dart';

class TradeButtons extends StatefulWidget {
  final String? initialTypeTrade;
  const TradeButtons({
    super.key,
    this.initialTypeTrade,
  });

  @override
  State<TradeButtons> createState() => _TradeButtonsState();
}

class _TradeButtonsState extends State<TradeButtons> {
  late String selectedTrade;

  @override
  void initState() {
    super.initState();
    selectedTrade = widget.initialTypeTrade ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isBuySelected = selectedTrade == 'BUY';
    final isSellSelected = selectedTrade == 'SELL';

    return Row(
      children: [
        Expanded(
          child: _buildTradeButton(
            'BUY',
            isBuySelected ? buyBottonStyle : unactiveBottonStyle,
            () {
              setState(() {
                context
                    .read<TransactionBloc>()
                    .add(UpdateTrade(selectedTrade = 'BUY'));
              });
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildTradeButton(
            'SELL',
            isSellSelected ? sellBottonStyle : unactiveBottonStyle,
            () {
              setState(() {
                context
                    .read<TransactionBloc>()
                    .add(UpdateTrade(selectedTrade = 'SELL'));
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTradeButton(
    String buttonName,
    Color buttonColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(buttonName, style: textBottonStyle),
    );
  }
}
