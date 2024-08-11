import 'package:flutter/material.dart';

class SumField extends StatelessWidget {
  final double? sumValue;

  const SumField({
    super.key,
    this.sumValue,
  });

  @override
  Widget build(BuildContext context) {
    // Отримуємо ширину екрану за допомогою MediaQuery
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width - 40, // Зменшити на відступи чи інші елементи, якщо потрібно
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Align(
          alignment: Alignment.centerLeft, // Вирівнювання тексту
          child: Text(
            sumValue != null ? sumValue.toString() : '0.0',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
