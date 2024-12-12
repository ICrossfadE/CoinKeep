import 'package:CoinKeep/firebase/lib/src/models/assetForWallet_model.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';

class CoinChart extends StatefulWidget {
  final List<AssetForWalletModel> coins;
  final double maxHeight;

  const CoinChart({
    required this.coins,
    this.maxHeight = 150,
    super.key,
  });

  @override
  State<CoinChart> createState() => _CoinChartState();
}

class _CoinChartState extends State<CoinChart> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _startAnimatiion();
  }

  Future<void> _startAnimatiion() async {
    _controller.forward();

    _controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Aбсолютний відсоток для нормалізації висоти

    // Від найменьгшого до найбільшого
    widget.coins.sort((a, b) => a.profitPercent!.compareTo(b.profitPercent!));

    final maxPercent = widget.coins.fold<double>(0, (max, item) {
      return max > item.profitPercent!.abs() ? max : item.profitPercent!.abs();
    });

    return SizedBox(
      height: widget.maxHeight,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.coins.length,
          itemBuilder: (context, index) {
            final coin = widget.coins[index];
            final profitPercent = coin.profitPercent ?? 0;
            final absolutePercent = profitPercent.abs();
            final isPositive = profitPercent > 0;

            // Нормалізуємо висоту стовпчика відносно максимального значення
            final normalizedHeight =
                (absolutePercent / maxPercent) * (widget.maxHeight / 2);

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
            style: kMiniText,
          ),
        if (positive)
          Text(
            '${(_progressAnimation.value * percent).toStringAsFixed(0)}%',
            style: kMiniText,
          ),
        if (positive)
          Container(
            width: 25,
            height: _progressAnimation.value * widgetHeight,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: kSellStyle,
              ),
            ),
          ),
        if (!positive)
          Container(
            width: 25,
            height: _progressAnimation.value * widgetHeight,
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
            height: _progressAnimation.value * widgetHeight,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: kBuyStyle,
              ),
            ),
          ),
        if (positive)
          Container(
            width: 25,
            height: _progressAnimation.value * widgetHeight,
            color: Colors.transparent,
          ),
        if (!positive)
          Text(
            '${(_progressAnimation.value * percent).toStringAsFixed(0)}%',
            style: kMiniText,
          ),
        if (positive)
          const Text(
            '',
            style: kMiniText,
          ),
      ],
    );
  }
}
