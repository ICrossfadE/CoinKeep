import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Sumfeild extends StatelessWidget {
  final double totalSum;
  const Sumfeild({super.key, required this.totalSum});

  @override
  Widget build(BuildContext context) {
    final _numberFormat = NumberFormat.decimalPattern('en_US');

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Sum \$',
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        readOnly: true,
        controller: TextEditingController(text: _numberFormat.format(totalSum)),
      ),
    );
  }
}
