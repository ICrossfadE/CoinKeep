import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final ValueChanged<String>? func;
  final String? hintName;
  final double? totalSum;
  final String? initialValue;

  const InputText({
    super.key,
    this.func,
    this.hintName,
    this.totalSum,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          // Використовуємо стандартну клавіатуру
          keyboardType: TextInputType.text,
          textAlign: TextAlign.center, // дозволяє вводити букви і цифри
          onChanged: (value) =>
              func?.call(value), // Безпечно викликаємо функцію
        ),
      ),
    );
  }
}
