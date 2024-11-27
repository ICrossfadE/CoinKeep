import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssetTitleInfo extends StatelessWidget {
  final String title;
  final String value;
  final String symbol;
  final String subtitle;
  final MainAxisAlignment aligmeent;
  final TextStyle? specialStyle;
  final TextStyle? specialSubstyle;

  const AssetTitleInfo({
    super.key,
    this.title = '',
    this.value = '',
    this.symbol = '',
    this.subtitle = '',
    this.aligmeent = MainAxisAlignment.start,
    this.specialStyle,
    this.specialSubstyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: kDark500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: aligmeent,
        children: [
          Column(
            children: [
              Text(
                title,
                style: kAssetTitle,
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: specialStyle ?? kAssetTitleFocus,
                  ),
                  Text(
                    '  $symbol',
                    style: kAssetTitleFocus,
                  )
                ],
              )
            ],
          ),
          Text(
            subtitle,
            style: specialSubstyle ?? kAssetTitleFocus,
          ),
        ],
      ),
    );
  }
}
