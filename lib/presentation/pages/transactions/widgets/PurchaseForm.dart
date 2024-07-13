import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({super.key});

  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  int quantity = 0;
  double price = 0.0;
  double sum = 0.0;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Quantity',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                quantity = int.tryParse(value) ?? 0;
                sum = quantity * price;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Price \$'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                price = double.tryParse(value) ?? 0.0;
                sum = quantity * price;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Sum \$'),
            readOnly: true,
            controller: TextEditingController(text: sum.toStringAsFixed(2)),
          ),
          InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null && picked != date) {
                setState(() {
                  date = picked;
                });
              }
            },
            child: InputDecorator(
              decoration: const InputDecoration(labelText: 'Date'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateFormat('dd.MM.yyyy HH:mm').format(date)),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process data
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
