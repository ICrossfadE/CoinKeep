import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? iconColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final IconData? buttonIcon;
  final String? buttonImageIcon;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double blurRadius;
  final double spreadRadius;
  final BorderSide buttonBorder;

  const WidthButton({
    this.borderRadius = 0.0,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.buttonBorder = BorderSide.none,
    this.buttonColor,
    this.iconColor = Colors.white,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          side: buttonBorder,
        ),
        foregroundColor: Colors.white,
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
            Icon(
              buttonIcon,
              color: iconColor,
            ),
          ],
        ],
      ),
    );
  }
}
