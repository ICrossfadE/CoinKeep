import 'package:CoinKeep/src/constants/dashboardConstant.dart';
import 'package:CoinKeep/presentation/widgets/SearchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import '../../widgets/CoinForm.dart';

class AddTransactionScreeen extends StatefulWidget {
  const AddTransactionScreeen({super.key});

  @override
  State<AddTransactionScreeen> createState() => _AddTransactionScreeenState();
}

class _AddTransactionScreeenState extends State<AddTransactionScreeen> {
  // Ініціалізація - LocalCacheBloc
  late LocalCacheBloc _coinsBloc;

  @override
  void initState() {
    super.initState();
    _coinsBloc = LocalCacheBloc();
  }

  @override
  void dispose() {
    _coinsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _coinsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Transactions',
            style: appBarStyle,
          ),
          backgroundColor: colorScheme.secondary,
        ),
        body: SafeArea(
          child: SizedBox(
            height: fullScreenHeight,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SearchField(onChanged: (value) {
                        _coinsBloc.add(SearchCoinsByName(value));
                      }),
                      const Expanded(
                        child: CoinForm(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
