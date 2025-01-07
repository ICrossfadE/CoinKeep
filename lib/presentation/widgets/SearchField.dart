import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

// Пошукова панель
class SearchField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: TextField(
          style: kSmallText.copyWith(color: Colors.white), // Білий колір тексту
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context)
                .colorScheme
                .tertiary
                .withOpacity(0.2), // Напівпрозора біла заливка на 90%
            hintText: 'Search coins...',
            hintStyle: kSmallTextP.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(130),
            ), // Білий колір для hintText
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none, // Відсутність рамки при enabled
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none, // Відсутність рамки при фокусі
            ),
          ),
          onChanged: onChanged,
        ));
  }
}
