import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.5, // Максимальна висота
      ),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          runSpacing: 25,
          children: [
            MaterialColorPicker(
              circleSize: 225,
              onColorChange: (Color color) {
                context
                    .read<SetWalletBloc>()
                    .add(UpdateColor(ColorUtils.colorToHex(color)));
                print(
                  'Selected Color: ${ColorUtils.colorToHex(color)}',
                ); // Виведення кольору в консоль
              },
              selectedColor: Colors.red,
            ),
            const SizedBox(height: 30),
            WidthButton(
              buttonColor: kConfirmColor,
              buttonText: 'Confirm',
              buttonTextStyle: kWidthButtonStyle,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
