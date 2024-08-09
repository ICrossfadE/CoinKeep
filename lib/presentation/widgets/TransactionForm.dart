import 'package:CoinKeep/firebase/lib/src/models/transaction.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/AmoutInput.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/PriceInput.dart';
import 'package:CoinKeep/presentation/widgets/TransactionForm/SumFeild.dart';

import 'package:CoinKeep/presentation/widgets/WalletsMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'TransactionForm/DatePicker.dart';
import 'TransactionForm/TraideButtons.dart';

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
  double amount = 0;
  double price = 0.0;
  double sum = 0.0;
  String typeTraide = '';
  String? chooseWallet;
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

  void _updatePrice(String value) {
    setState(() {
      price = _numberFormat.parse(value).toDouble();
      _updateSum();
    });
  }

  void _updateAmount(String value) {
    setState(() {
      amount = _numberFormat.parse(value).toDouble();
      _updateSum();
    });
  }

  void _updateDate(DateTime picked) {
    setState(() {
      date = picked;
    });
  }

  void _chngeTrade(String type) {
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
          TraideButtons(onChanged: _chngeTrade),
          const SizedBox(height: 10),
          WalletsMenu(
            walletName: chooseWallet,
            onChanged: _updateWallet,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AmoutInput(onChanged: _updateAmount),
              const SizedBox(width: 10),
              PriceInput(onChanged: _updatePrice)
            ],
          ),
          const SizedBox(height: 10),
          Sumfeild(totalSum: sum),
          const SizedBox(height: 10),
          DatePicker(date: date, onChanged: _updateDate),
          const SizedBox(height: 10),
          newTransactionsButton(context)
        ],
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
