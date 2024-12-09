class AssetForWalletModel {
  final String? walletId;
  final String? symbol;
  final double? profitPercent;
  final double totalInvest;
  final double totalCurentSum;
  final int? icon;

  AssetForWalletModel({
    required this.walletId,
    required this.symbol,
    required this.profitPercent,
    this.totalInvest = 0.00,
    this.totalCurentSum = 0.00,
    required this.icon,
  });

  // Метод для конвертації JSON в модель
  factory AssetForWalletModel.fromJson(Map<String, dynamic> json) {
    return AssetForWalletModel(
      walletId: json['walletId'] as String,
      symbol: json['symbol'] as String,
      profitPercent: json['profitPercent'] as double,
      totalInvest: json['totalInvest'] as double,
      totalCurentSum: json['totalCurentSum'] as double,
      icon: json['icon'] as int,
    );
  }

  // Метод для конвертації моделі в JSON
  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'symbol': symbol,
      'profitPercent': profitPercent,
      'totalInvest': totalInvest,
      'totalCurentSum': totalCurentSum,
      'icon': icon,
    };
  }
}
