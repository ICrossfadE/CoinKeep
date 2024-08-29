import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  final Color? buttonColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final IconData? buttonIcon;
  final String? buttonImageIcon;
  final VoidCallback? onPressed;

  const WidthButton({
    this.buttonColor,
    this.buttonText,
    this.buttonTextStyle,
    this.buttonImageIcon,
    this.buttonIcon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (buttonImageIcon != null) ...[
            Image(
              image: AssetImage(buttonImageIcon ?? ''),
              height: 24,
            ),
            const SizedBox(width: 10),
          ],
          Text(
            buttonText ?? 'Text',
            style: buttonTextStyle,
          ),
          if (buttonIcon != null) ...[
            const SizedBox(width: 10), // Проміжок між текстом та іконкою
            Icon(buttonIcon),
          ],
        ],
      ),
    );
  }
}
