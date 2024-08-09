import 'package:flutter/material.dart';

import '../../../src/constants/transactionCanstants.dart';

enum TraideType { buy, sell }

class TraideButtons extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const TraideButtons({
    super.key,
    required this.onChanged,
  });

  @override
  State<TraideButtons> createState() => _TraideButtonsState();
}

class _TraideButtonsState extends State<TraideButtons> {
  Color buttonBUY = unactiveBottonStyle;
  Color buttonSELL = unactiveBottonStyle;

  void chngeTrade(TraideType traide) {
    setState(() {
      if (traide == TraideType.buy) {
        buttonBUY = buyBottonStyle;
        buttonSELL = unactiveBottonStyle;
        widget.onChanged('BUY');
      } else if (traide == TraideType.sell) {
        buttonSELL = sellBottonStyle;
        buttonBUY = unactiveBottonStyle;
        widget.onChanged('SELL');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildTradeButton('BUY', buttonBUY, TraideType.buy),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildTradeButton('SELL', buttonSELL, TraideType.sell),
        ),
      ],
    );
  }

  Widget _buildTradeButton(
      String bottonName, Color bottonColor, TraideType traide) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bottonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(bottonName, style: textBottonStyle),
      onPressed: () => chngeTrade(traide),
    );
  }
}
