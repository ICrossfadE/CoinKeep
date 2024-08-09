import 'package:CoinKeep/firebase/lib/src/models/transaction.dart';

import 'package:CoinKeep/presentation/widgets/WalletsMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'TraideButtons.dart';

class TransactionForm extends StatefulWidget {
  final int iconId;
  final String coinSymbol;
  const TransactionForm(
      {super.key, required this.iconId, required this.coinSymbol});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _numberFormat = NumberFormat.decimalPattern('en_US');
  String uid = '';
  String typeTraide = '';
  String? chooseWallet;
  double amount = 0;
  double price = 0.0;
  double sum = 0.0;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    getUID();
  }

  void _updateSum() {
    sum = amount * price;
  }

  void _updateWallet(String wallet) {
    setState(() {
      chooseWallet = wallet;
    });
  }

  void chngeTrade(String type) {
    setState(() {
      typeTraide = type;
    });
  }

  Future<void> getUID() async {
    try {
      final User? user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          uid = user.uid;
        });
      } else {
        print('User not loginet');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          TraideButtons(
            onChanged: chngeTrade,
          ),
          const SizedBox(height: 10),
          WalletsMenu(
            walletName: chooseWallet,
            onChanged: _updateWallet,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              amountInput(context),
              const SizedBox(width: 10),
              priceInput(context)
            ],
          ),
          const SizedBox(height: 10),
          sumFeild(context),
          const SizedBox(height: 10),
          datePicker(context),
          const SizedBox(height: 10),
          newTransactionsButton(context)
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
              amount = _numberFormat.parse(value).toDouble();
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
        var uuid = const Uuid();
        final newTransaction = TransactionsModel(
          id: uuid.v4(), // uid це ваш ідентифікатор
          wallet: chooseWallet,
          type: typeTraide,
          symbol: widget.coinSymbol,
          icon: widget.iconId,
          price: price,
          amount: amount, // Приклад суми
          date: date, // Поточна дата
        );

        _firestore.collection('users').doc(uid).update({
          'transactions': FieldValue.arrayUnion([newTransaction.toJson()])
        });
        print(uid);
        Navigator.pop(context);
      },
      child: const Text(
        'Create',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
