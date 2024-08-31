import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onChanged;

  const DatePicker({
    super.key,
    required this.onChanged,
    this.initialDate,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime currentDate =
            selectedDate ?? initialDate ?? DateTime.now();

        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: currentDate, // Використання обраної або початкової дати
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null && picked != selectedDate) {
          onChanged(picked); // Викликаємо onChanged з новою датою
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InputDecorator(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                // Відображення обраної або початкової дати
                DateFormat('dd.MM.yyyy').format(
                  selectedDate ?? initialDate ?? DateTime.now(),
                ),
                style: const TextStyle(
                  color: Colors.white38,
                ),
              ),
              const Icon(
                Icons.calendar_today,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
