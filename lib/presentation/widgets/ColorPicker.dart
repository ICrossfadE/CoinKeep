import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ColorPicker extends StatelessWidget {
  final String? initialColor;
  final ValueChanged<Color>? onConfirm;
  const ColorPicker({
    this.initialColor,
    this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Змінна для зберігання обраного кольору
    Color? selectedColor = ColorUtils.hexToColor(initialColor!);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.5, // Максимальна висота
      ),
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 25,
          children: [
            Center(
              child: MaterialColorPicker(
                onColorChange: (Color color) {
                  selectedColor = color;
                },
                selectedColor: ColorUtils.hexToColor(initialColor!),
              ),
            ),
            const SizedBox(height: 30),
            WidthButton(
              buttonColor: kConfirmColor.withAlpha(200),
              buttonText: 'Confirm',
              buttonTextStyle: kMediumText,
              borderRadius: 10,
              buttonBorder: const BorderSide(width: 2, color: kConfirmColor),
              onPressed: () {
                // Викликаємо колбек, передаючи обраний колір
                if (onConfirm != null && selectedColor != null) {
                  onConfirm!(selectedColor!);
                }
                Navigator.pop(context); // Закриваємо діалог
              },
            ),
          ],
        ),
      ),
    );
  }
}
