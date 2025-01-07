import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class DismisibleButton extends StatelessWidget {
  final String? textButton;
  final Color color;
  final IconData? icon;
  final AlignmentGeometry? aligment;
  final AlignmentGeometry gradientBeginAligment;
  final AlignmentGeometry gradientEndAligment;
  const DismisibleButton({
    required this.color,
    required this.gradientBeginAligment,
    required this.gradientEndAligment,
    this.icon,
    this.aligment,
    this.textButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      alignment: aligment,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: gradientBeginAligment,
          end: gradientEndAligment,
          colors: [
            Colors.transparent,
            color.withOpacity(0.1),
            color.withOpacity(0.7),
          ],
          stops: const [0.0, 0.3, 1.0],
        ),
        borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(8), left: Radius.circular(8)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: Colors.white,
          ),
          Text(
            textButton!,
            textAlign: TextAlign.left,
            style: kSmallText.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
