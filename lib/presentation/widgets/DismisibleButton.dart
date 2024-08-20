import 'package:flutter/material.dart';

class DismisibleButton extends StatelessWidget {
  final String? textButton;
  final Color? color;
  final IconData? icon;
  final AlignmentGeometry? aligment;
  const DismisibleButton({
    this.icon,
    this.aligment,
    this.color,
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
        color: color,
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            textButton!,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
