import 'package:flutter/material.dart';

class ColorUtils {
  // Метод для перетворення кольору в HEX формат
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  // Метод для перетворення HEX формату в Color
  static Color hexToColor(String hex) {
    final hexCode = hex.replaceAll('#', '');
    final intValue = int.parse(hexCode, radix: 16);
    return Color(intValue | 0xFF000000);
  }
}
