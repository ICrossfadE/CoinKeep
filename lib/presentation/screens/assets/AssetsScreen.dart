import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/AssetCard.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<AssetCubit, TransactionState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total Assets: ${state.assets.length}'),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<AssetCubit, TransactionState>(
              builder: (context, state) {
                if (state.assets.isEmpty) {
                  return const Center(child: Text('No transactions found.'));
                }
                return ListView.builder(
                  itemCount: state.assets.length,
                  itemBuilder: (context, index) {
                    final asset = state.assets[index];
                    return GestureDetector(
                      child: AssetCard(
                        wallet: asset.wallet,
                        symbol: asset.symbol,
                        icon: asset.icon,
                        transaction: asset.transactions,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteId.assetDetails,
                          arguments: {
                            'transactionList': asset.transactions,
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
