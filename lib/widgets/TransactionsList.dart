import 'package:CoinKeep/bloc/transactions_bloc.dart';
import 'package:CoinKeep/counter_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = CounterBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => bloc,
        ),
        BlocProvider<TransactionsBloc>(
          create: (context) => TransactionsBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                bloc.add(IncrementEvent());
                print('Add new Transactions');
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                bloc.add(DecrementEvent());
                print('Delete Transactions');
              },
              icon: const Icon(Icons.exposure_minus_1),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<CounterBloc, int>(
            bloc: bloc,
            builder: (context, state) {
              return Text(state.toString(), style: TextStyle(fontSize: 33));
            },
          ),
        ),
      ),
    );
  }
}










// floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print('Add new Transactions');
//         },
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         child: const Icon(
//           CupertinoIcons.add,
//           color: Colors.white,
//         ),
//       ),