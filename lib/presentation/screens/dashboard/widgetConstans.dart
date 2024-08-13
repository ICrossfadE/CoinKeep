import 'package:flutter/material.dart';

List<String> navButtonsNames = [
  'Home',
  'Wallets',
  'Assets',
  'Transactions',
  'Profile'
];

Map<String, dynamic> navButtonsIcons = {
  'Home': const Icon(Icons.home),
  'Wallets': const Icon(Icons.account_balance_wallet),
  'Assets': const Icon(Icons.control_point_duplicate_rounded),
  'Transactions': const Icon(Icons.import_export_rounded),
  'Profile': const Icon(Icons.person),
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
