import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/widgets.dart';

class ColorView extends StatelessWidget {
  final String? colorValue;

  const ColorView({this.colorValue = '#FFE64A19', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      // height: 50,
      decoration: BoxDecoration(
        color: ColorUtils.hexToColor(colorValue!),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    );
  }
}
