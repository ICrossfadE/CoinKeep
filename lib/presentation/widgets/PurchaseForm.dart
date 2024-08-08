import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({super.key});

  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final _numberFormat = NumberFormat.decimalPattern('en_US');
  double quantity = 0;
  double price = 0.0;
  double sum = 0.0;
  DateTime date = DateTime.now();

  void _updateSum() {
    sum = quantity * price;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              amountInput(context),
              const SizedBox(width: 20),
              priceInput(context)
            ],
          ),
          const SizedBox(height: 20),
          sumFeild(context),
          const SizedBox(height: 20),
          datePicker(context),
          const SizedBox(height: 20),
          newTransactionsButton(context)
          // ElevatedButton(
          //   child: const Text('Close BottomSheet'),
          //   onPressed: () => Navigator.pop(context),
          // ),
        ],
      ),
    );
  }

  // AMOUNT
  Widget amountInput(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Amount',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true), //!!!!
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) {
            setState(() {
              quantity = _numberFormat.parse(value).toDouble();
              _updateSum();
            });
          },
        ),
      ),
    );
  }

  // PRICE
  Widget priceInput(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Price \$',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) {
            setState(() {
              price = _numberFormat.parse(value).toDouble();
              _updateSum();
            });
          },
        ),
      ),
    );
  }

  // SUM FEILD
  Widget sumFeild(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Sum \$',
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        readOnly: true,
        controller: TextEditingController(text: _numberFormat.format(sum)),
      ),
    );
  }

  // DATE
  Widget datePicker(BuildContext context) {
    return InkWell(
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
              Text(DateFormat('dd.MM.yyyy').format(date)),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }

  // CREATE BUTTOn
  Widget newTransactionsButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        // if (_formKey.currentState!.validate()) {
        // }
      },
      child: const Text(
        'Create',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
