import 'package:flutter/material.dart';

import '../../../../data/utilities/constans/transactionCanstants.dart';

enum TraideType { buy, sell }

class TraideButtons extends StatefulWidget {
  const TraideButtons({super.key});

  @override
  State<TraideButtons> createState() => _TraideButtonsState();
}

class _TraideButtonsState extends State<TraideButtons> {
  Color buttonBUY = unactiveBottonStyle;
  Color buttonSELL = unactiveBottonStyle;

  void chngeTrade(TraideType traide) {
    setState(() {
      buttonBUY =
          traide == TraideType.buy ? buyBottonStyle : unactiveBottonStyle;
      buttonSELL =
          traide == TraideType.sell ? sellBottonStyle : unactiveBottonStyle;
    });
  }

  Widget _buildTradeButton(
      String bottonName, Color bottonColor, TraideType traide) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bottonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(bottonName, style: textBottonStyle),
        onPressed: () => chngeTrade(traide),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTradeButton('BUY', buttonBUY, TraideType.buy),
        const SizedBox(width: 20),
        _buildTradeButton('SELL', buttonSELL, TraideType.sell),
      ],
    );
  }
}
