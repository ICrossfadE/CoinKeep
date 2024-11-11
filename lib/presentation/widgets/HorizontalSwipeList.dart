import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/assetForWallet_model.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_asset_cubit.dart';
import 'package:CoinKeep/logic/blocs/getTransactions_cubit/get_transactions_cubit.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalSwipeList extends StatefulWidget {
  final List<WalletEntity> wallets;

  const HorizontalSwipeList({
    required this.wallets,
    super.key,
  });

  @override
  State<HorizontalSwipeList> createState() => _HorizontalSwipeListState();
}

class _HorizontalSwipeListState extends State<HorizontalSwipeList> {
  void _onFocusItem(int index) {
    return setState(() {
      widget.wallets[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Swiper(
          itemBuilder: _buildListItem,
          itemCount: widget.wallets.length,
          loop: false,
          onIndexChanged: (int index) {
            _onFocusItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              color: ColorUtils.hexToColor(widget.wallets[index].walletColor!),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.wallets[index].walletName}',
                    style: styleWalletTitle,
                  ),
                  // const Text(
                  //   '+100%',
                  //   style: styleWalletProfit,
                  // ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
            builder: (context, transactionState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: BlocBuilder<AssetCubit, GetTransactionsState>(
                  builder: (context, assetState) {
                    // Ключ до списку з данними
                    final keyForItems = widget.wallets[index].walletId;
                    final List<AssetForWalletModel>? items =
                        assetState.assetsForWallet[keyForItems];

                    print('CUbit ${assetState.assetsForWallet}');

                    // Якщо список порожній
                    if (items == null || items.isEmpty) {
                      return const Center(
                        child: Text(
                          'Empty',
                          style: TextStyle(color: Colors.amber),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                maxRadius: 12,
                                child: Image.network(
                                  'https://s2.coinmarketcap.com/static/img/coins/64x64/${items[index].icon!}.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${(items[index].profitPercent!).toStringAsFixed(2)}%',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
