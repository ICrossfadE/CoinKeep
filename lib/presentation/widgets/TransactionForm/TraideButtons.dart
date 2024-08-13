import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CoinKeep/logic/blocs/transaction_bloc/transaction_bloc.dart';
import '../../../src/constants/transactionCanstants.dart';

enum TradeType { buy, sell }

class TradeButtons extends StatelessWidget {
  const TradeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final isBuySelected = state.typeTrade == 'BUY';
        final isSellSelected = state.typeTrade == 'SELL';

        return Row(
          children: [
            Expanded(
              child: _buildTradeButton(
                'BUY',
                isBuySelected ? buyBottonStyle : unactiveBottonStyle,
                TradeType.buy,
                context,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildTradeButton(
                'SELL',
                isSellSelected ? sellBottonStyle : unactiveBottonStyle,
                TradeType.sell,
                context,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTradeButton(
    String buttonName,
    Color buttonColor,
    TradeType tradeType,
    BuildContext context,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(buttonName, style: textBottonStyle),
      onPressed: () {
        context.read<TransactionBloc>().add(UpdateTrade(buttonName));
      },
    );
  }
}
