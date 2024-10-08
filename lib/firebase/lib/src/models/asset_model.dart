class AssetModel {
  final String? symbol;
  final String? wallet;
  final String? name;
  final double? totalInvest;
  final double? totalCoins;
  final double? averagePrice;
  final double? currentPrice;
  final double? profitPercent;
  final double? fixedProfit;
  final double? profit;
  final int? icon;
  // final List<TransactionEntity> transactions;

  AssetModel({
    required this.symbol,
    required this.name,
    required this.wallet,
    required this.totalInvest,
    required this.totalCoins,
    required this.averagePrice,
    required this.currentPrice,
    required this.profitPercent,
    required this.fixedProfit,
    required this.profit,
    required this.icon,
    // required this.transactions,
  });

  // Метод для конвертації JSON в модель
  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      wallet: json['wallet'] as String,
      totalInvest: json['totalInvest'] as double,
      totalCoins: json['totalCoins'] as double,
      averagePrice: json['averagePrice'] as double,
      currentPrice: json['currentPrice'] as double,
      profitPercent: json['profitPercent'] as double,
      fixedProfit: json['fixedProfit'] as double,
      profit: json['profit'] as double,
      icon: json['icon'] as int,
      // transactions: (json['transaction'] as List<dynamic>)
      //     .map((item) =>
      //         TransactionEntity.fromDocument(item as Map<String, dynamic>))
      //     .toList(),
    );
  }

  // Метод для конвертації моделі в JSON
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'wallet': wallet,
      'totalInvest': totalInvest,
      'totalCoins': totalCoins,
      'averagePrice': averagePrice,
      'currentPrice': currentPrice,
      'profitPercent': profitPercent,
      'fixedProfit': fixedProfit,
      'profit': profit,
      'icon': icon,
      // 'transaction': transactions.map((item) => item.toDocument()).toList(),
    };
  }
}
