import 'package:flutter/material.dart';

// Пошукова панель
class SearchField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          style: const TextStyle(color: Colors.white), // Білий колір тексту
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white
                .withOpacity(0.1), // Напівпрозора біла заливка на 80%
            hintText: 'Search coins...',
            hintStyle: const TextStyle(
                color: Colors.white38), // Білий колір для hintText
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
