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
      '#FFE53935',
      '#FFD81B60',
      '#FF8E24AA',
      '#FF5E35B1',
      '#FF3949AB',
      '#FF1E88E5',
      '#FF039BE5',
      '#FF00ACC1',
      '#FF00897B',
      '#FF43A047',
      '#FF7CB342',
      '#FFC0CA33',
      '#FFFDD835',
      '#FFFFB300',
      '#FFFB8C00',
      '#FFF4511E',
      '#FF6D4C41',
      '#FF757575',
      '#FF546E7A',
    ];

    return colorList[random.nextInt(colorList.length)];
  }
}
