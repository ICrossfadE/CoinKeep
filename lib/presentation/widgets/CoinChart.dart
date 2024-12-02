import 'package:CoinKeep/firebase/lib/src/models/assetForWallet_model.dart';
import 'package:flutter/material.dart';

class CoinChart extends StatelessWidget {
  final List<AssetForWalletModel> coins;
  final double maxHeight;

  const CoinChart({
    required this.coins,
    this.maxHeight = 150,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Aбсолютний відсоток для нормалізації висоти

    // Від найменьгшого до найбільшого
    coins.sort((a, b) => a.profitPercent!.compareTo(b.profitPercent!));

    final maxPercent = coins.fold<double>(0, (max, item) {
      return max > item.profitPercent!.abs() ? max : item.profitPercent!.abs();
    });

    return SizedBox(
      height: maxHeight,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: coins.length,
          itemBuilder: (context, index) {
            final coin = coins[index];
            final profitPercent = coin.profitPercent ?? 0;
            final absolutePercent = profitPercent.abs();
            final isPositive = profitPercent > 0;

            // Нормалізуємо висоту стовпчика відносно максимального значення
            final normalizedHeight =
                (absolutePercent / maxPercent) * (maxHeight / 2);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCoinPercentPositive(
                        isPositive, profitPercent, normalizedHeight),
                    const SizedBox(height: 4),

                    // Іконка криптовалюти
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12,
                      child: Image.network(
                        'https://s2.coinmarketcap.com/static/img/coins/64x64/${coin.icon}.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.currency_bitcoin,
                          size: 24,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),
                    _buildCoinPercentNegative(
                      isPositive,
                      profitPercent,
                      normalizedHeight,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCoinPercentPositive(
      bool positive, double percent, double widgetHeight) {
    return Column(
      children: [
        if (!positive)
          const Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        if (positive)
          Text(
            '${percent.toStringAsFixed(0)}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        if (positive)
          Container(
            width: 25,
            height: widgetHeight,
            color: Colors.green,
          ),
        if (!positive)
          Container(
            width: 25,
            height: widgetHeight,
            color: Colors.transparent,
          )
      ],
    );
  }

  Widget _buildCoinPercentNegative(
      bool positive, double percent, double widgetHeight) {
    return Column(
      children: [
        if (!positive)
          Container(
            width: 25,
            height: widgetHeight,
            color: Colors.red,
          ),
        if (positive)
          Container(
            width: 25,
            height: widgetHeight,
            color: Colors.transparent,
          ),
        if (!positive)
          Text(
            '${percent.toStringAsFixed(0)}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        if (positive)
          const Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
