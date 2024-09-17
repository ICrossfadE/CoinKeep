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
          color: Colors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          initialValue: initialValue?.replaceAll(RegExp(r'^[-\s]+'), '') ?? '',
          decoration: InputDecoration(
            hintText: hintName,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.white38),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) => func
              ?.call(value), // Безпечно викликаємо функцію, якщо вона не null
        ),
      ),
    );
  }
}
