import 'package:CoinKeep/presentation/widgets/SearchField.dart';
import 'package:CoinKeep/src/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/local_cache_bloc/local_cache_bloc.dart';

import '../../widgets/CoinList.dart';

class SearchCoinsScreen extends StatefulWidget {
  const SearchCoinsScreen({super.key});

  @override
  State<SearchCoinsScreen> createState() => _AddTransactionScreeenState();
}

class _AddTransactionScreeenState extends State<SearchCoinsScreen> {
  // Ініціалізація - LocalCacheBloc
  late LocalCacheBloc _coinsBloc;

  @override
  void initState() {
    super.initState();
    _coinsBloc = LocalCacheBloc();
    // Скинути стан до початкового при вході на екран
    _coinsBloc.add(ResetSearch());
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
            style: kAppBarStyle,
          ),
          backgroundColor: colorScheme.secondary,
          iconTheme: const IconThemeData(
            color: Colors.white, // Колір кнопки назад
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: fullScreenHeight,
            child: Stack(
              children: [
                Column(
                  children: [
                    SearchField(onChanged: (value) {
                      _coinsBloc.add(SearchCoinsByName(value));
                    }),
                    const Expanded(
                      child: CoinList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
