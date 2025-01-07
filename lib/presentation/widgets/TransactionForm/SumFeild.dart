import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class SumField extends StatefulWidget {
  final double? sumValue;
  final double? initialSum;

  const SumField({
    super.key,
    this.sumValue,
    this.initialSum,
  });

  @override
  _SumFieldState createState() => _SumFieldState();
}

class _SumFieldState extends State<SumField> {
  late String displayValue;

  @override
  void initState() {
    super.initState();
    // Встановлюємо початкове значення для displayValue
    displayValue = ((widget.initialSum?.toStringAsFixed(2) ?? 0.0).toString())
        .replaceAll(RegExp(r'^[-\s]+'), '');
  }

  @override
  void didUpdateWidget(SumField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Оновлюємо displayValue, якщо sumValue змінилось
    if (widget.sumValue != null && widget.sumValue != oldWidget.sumValue) {
      setState(() {
        displayValue = widget.sumValue!.toStringAsFixed(2).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Отримуємо ширину екрану за допомогою MediaQuery
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width - 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "\$$displayValue",
            style: kSmallText,
          ),
        ),
      ),
    );
  }
}
