import 'transaction_model.dart';

class AssetModel {
  final String? symbol;
  final String? wallet;
  final int? icon;
  final List<TransactionsModel> transactions;

  AssetModel({
    required this.symbol,
    required this.wallet,
    required this.icon,
    required this.transactions,
  });

  // Метод для конвертації JSON в модель
  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      symbol: json['symbol'] as String,
      wallet: json['wallet'] as String,
      icon: json['icon'] as int,
      transactions: (json['transaction'] as List<dynamic>)
          .map((item) =>
              TransactionsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Метод для конвертації моделі в JSON
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'wallet': wallet,
      'icon': icon,
      'transaction': transactions.map((item) => item.toJson()).toList(),
    };
  }
}
