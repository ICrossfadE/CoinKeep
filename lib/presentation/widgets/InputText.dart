import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController? textController;
  final ValueChanged<String>? func;
  final String? hintName;

  const InputText({
    super.key,
    this.func,
    this.hintName,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
            autofocus: true,
            controller: textController,
            style: kSmallText,
            decoration: InputDecoration(
              hintText: hintName,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: InputBorder.none,
              hintStyle: kSmallText,
            ),
            // Використовуємо стандартну клавіатуру
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center, // дозволяє вводити букви і цифри
            onChanged: (value) =>
                func?.call(value) // Безпечно викликаємо функцію
            ),
      ),
    );
  }
}
