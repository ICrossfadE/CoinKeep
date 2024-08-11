import 'package:CoinKeep/logic/blocs/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SumFeild extends StatelessWidget {
  final double? sumValue;

  const SumFeild({
    super.key,
    this.sumValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return TextFormField(
            initialValue: sumValue?.toString(),
            decoration: const InputDecoration(
              hintText: 'Sum',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            keyboardType: TextInputType.text,
          );
        },
      ),
    );
  }
}
