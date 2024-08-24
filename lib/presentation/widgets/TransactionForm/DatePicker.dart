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
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InputDecorator(
          decoration: const InputDecoration(
            hintText: 'Date',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                DateFormat('dd.MM.yyyy').format(selectedDate ??
                    initialDate ??
                    DateTime.now()), // Відображення обраної або початкової дати
              ),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}
