import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  // Метод для перетворення кольору в HEX формат
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  // Метод для перетворення HEX формату в Color
  static Color hexToColor(String hex) {
    // Перевіряємо чи рядок починається з # і має правильну кількість символів
    if (!RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$').hasMatch(hex)) {
      throw FormatException("Invalid HEX color format");
    }

    final hexCode = hex.replaceAll('#', '');
    final intValue = int.parse(hexCode, radix: 16);
    return Color(intValue | 0xFF000000);
  }

  // Метод який повертає випадковий колір зі списку
  static String randomColorHex() {
    final random = Random();
    const List<String> colorList = [
      '#FFFFEBEE',
      '#FFFFCDD2',
      '#FFEF9A9A',
      '#FFE57373',
      '#FFEF5350',
      '#FFF44336',
      '#FFE53935',
      '#FFD32F2F',
      '#FFC62828',
      '#FFB71C1C',
    ];

    return colorList[random.nextInt(colorList.length)];
  }
}
