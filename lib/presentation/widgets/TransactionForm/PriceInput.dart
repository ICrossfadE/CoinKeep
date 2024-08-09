import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const PriceInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Price \$',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
