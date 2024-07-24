import 'package:flutter/material.dart';

class WallletsMenu extends StatefulWidget {
  const WallletsMenu({super.key});

  @override
  State<WallletsMenu> createState() => _WallletsMenuState();
}

class _WallletsMenuState extends State<WallletsMenu> {
  String? chooseWalet;

  void _changeWallet(wallet) {
    setState(() {
      chooseWalet = wallet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Choose wallet'),
      value: chooseWalet,
      isExpanded: true,
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(Icons.account_balance_wallet),
      items: const [
        DropdownMenuItem(value: 'Binance', child: Text('Binance')),
        DropdownMenuItem(value: 'MetaMask', child: Text('MetaMask')),
        DropdownMenuItem(value: 'OKEx', child: Text('OKEx')),
        DropdownMenuItem(value: 'Keplr', child: Text('Keplr')),
      ],
      onChanged: (value) {
        _changeWallet(value);
      },
    );
  }
}
