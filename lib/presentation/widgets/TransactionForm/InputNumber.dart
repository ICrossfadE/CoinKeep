import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final ValueChanged<String>? func;
  final String? hintName;
  final double? totalSum;
  final String? initialValue;

  const NumberInput({
    super.key,
    this.func,
    this.hintName,
    this.totalSum,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
            style: kSmallText,
            initialValue:
                initialValue?.replaceAll(RegExp(r'^[-\s]+'), '') ?? '',
            decoration: InputDecoration(
              hintText: hintName,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: InputBorder.none,
              hintStyle: kSmallText,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            onChanged: (value) => func?.call(
                value) // Безпечно викликаємо функцію, якщо вона не null),
            ),
      ),
    );
  }
}
