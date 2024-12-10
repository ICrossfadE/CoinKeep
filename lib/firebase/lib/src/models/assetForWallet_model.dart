class AssetForWalletModel {
  final String? walletId;
  final String? symbol;
  final double? profitPercent;
  final int? icon;

  AssetForWalletModel({
    required this.walletId,
    required this.symbol,
    required this.profitPercent,
    required this.icon,
  });

  // Метод для конвертації JSON в модель
  factory AssetForWalletModel.fromJson(Map<String, dynamic> json) {
    return AssetForWalletModel(
      walletId: json['walletId'] as String,
      symbol: json['symbol'] as String,
      profitPercent: json['profitPercent'] as double,
      icon: json['icon'] as int,
    );
  }

  // Метод для конвертації моделі в JSON
  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'symbol': symbol,
      'profitPercent': profitPercent,
      'icon': icon,
    };
  }
}
