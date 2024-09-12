import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/widgets.dart';

class ColorView extends StatelessWidget {
  final String? colorValue;

  const ColorView({this.colorValue = '#FFE64A19', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Встановлюємо фіксовану висоту
      decoration: BoxDecoration(
        color: ColorUtils.hexToColor(colorValue!),
        borderRadius: BorderRadius.circular(
          10,
        ), // Заокруглені кути 10px
      ),
    );
  }
}
