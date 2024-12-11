import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  final Color? buttonColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final IconData? buttonIcon;
  final String? buttonImageIcon;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double blurRadius;
  final double spreadRadius;

  const WidthButton({
    this.borderRadius = 0.0,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          side: const BorderSide(
            color: Colors.white30, // Колір бордера
            width: 2.0, // Товщина бордера
          ),
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
            Icon(buttonIcon),
          ],
        ],
      ),
    );
  }
}


// Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: blurRadius,
//             blurStyle: BlurStyle.normal,
//             color: Colors.black.withOpacity(0.1),
//             offset: Offset.zero,
//             spreadRadius: spreadRadius,
//           ),
//         ],
//       ),
//       child: 
//     );