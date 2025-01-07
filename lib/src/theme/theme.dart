import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/theme/light.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: kLightBg,
    onSurface: kDarkBg,
    primary: kLight100,
    secondary: kLight500,
    tertiary: kLight100,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: kDarkBg,
    onSurface: kLightBg,
    primary: kDark500,
    secondary: kDark100,
    tertiary: kDark100,
  ),
);
