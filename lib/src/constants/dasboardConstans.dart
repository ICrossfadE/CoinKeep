import 'package:flutter/material.dart';

const List<String> navButtonsNames = [
  'Home',
  'Wallets',
  'Assets',
  'Transactions',
  'Profile'
];

const Map<String, dynamic> navButtonsIcons = {
  'Home': Icon(Icons.home),
  'Wallets': Icon(Icons.account_balance_wallet),
  'Assets': Icon(Icons.control_point_duplicate_rounded),
  'Transactions': Icon(Icons.import_export_rounded),
  'Profile': Icon(Icons.person),
};

const TextStyle styleWalletTitle = TextStyle(
  fontSize: 50.0,
  color: Colors.black,
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.bold,
);

const TextStyle styleWalletProfit = TextStyle(
  fontSize: 25.0,
  color: Colors.white,
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.bold,
);
