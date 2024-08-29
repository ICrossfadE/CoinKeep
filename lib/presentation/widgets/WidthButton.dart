import 'package:CoinKeep/src/constants/transactionCanstants.dart';
import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  final Color? buttonColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final VoidCallback? onPressed;

  const WidthButton({
    this.buttonColor,
    this.buttonText,
    this.buttonTextStyle,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText ?? 'Text',
        style: textBottonStyle,
      ),
    );
  }
}
