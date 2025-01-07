import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/theme/light.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: kLightBg,
    onSurface: kDarkBg,
    primary: kLight100,
    onPrimary: kLight400,
    secondary: kLight500,
    tertiary: kLight100,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: kDarkBg,
    onSurface: kLightBg,
    primary: kDark100,
    onPrimary: kDark400,
    secondary: kDark500,
    tertiary: kDark100,
  ),
);
