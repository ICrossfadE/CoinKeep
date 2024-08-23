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
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          initialValue:
              (initialValue.toString()).replaceAll(RegExp(r'^[-\s]+'), ''),
          decoration: InputDecoration(
            hintText: hintName,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) => func!(value),
        ),
      ),
    );
  }
}
