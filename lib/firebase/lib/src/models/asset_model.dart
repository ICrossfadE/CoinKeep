import '../entities/transaction_entities.dart';

class AssetModel {
  // final String? symbol;
  final String? wallet;
  final String? name;
  final double? totalSum;
  final int? icon;
  final List<TransactionEntity> transactions;

  AssetModel({
    // required this.symbol,
    required this.name,
    required this.wallet,
    required this.totalSum,
    required this.icon,
    required this.transactions,
  });

  // Метод для конвертації JSON в модель
  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      // symbol: json['symbol'] as String,
      name: json['name'] as String,
      wallet: json['wallet'] as String,
      totalSum: json['totalSum'] as double,
      icon: json['icon'] as int,
      transactions: (json['transaction'] as List<dynamic>)
          .map((item) =>
              TransactionEntity.fromDocument(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Метод для конвертації моделі в JSON
  Map<String, dynamic> toJson() {
    return {
      // 'symbol': symbol,
      'name': name,
      'wallet': wallet,
      'totalSum': totalSum,
      'icon': icon,
      'transaction': transactions.map((item) => item.toDocument()).toList(),
    };
  }
}
