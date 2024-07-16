import 'dart:convert';

TransactionsModel transactionsModelFromJson(String str) =>
    TransactionsModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionsModel data) =>
    json.encode(data.toJson());

class TransactionsModel {
  String id;
  String nameWalet;
  String symbol;
  String amount;
  int marketPrice;
  String typeTrade;
  String date;

  TransactionsModel({
    required this.id,
    required this.nameWalet,
    required this.symbol,
    required this.amount,
    required this.marketPrice,
    required this.typeTrade,
    required this.date,
  });

  TransactionsModel copyWith({
    String? id,
    String? nameWalet,
    String? symbol,
    String? amount,
    int? marketPrice,
    String? typeTrade,
    String? date,
  }) =>
      TransactionsModel(
        id: id ?? this.id,
        nameWalet: nameWalet ?? this.nameWalet,
        symbol: symbol ?? this.symbol,
        amount: amount ?? this.amount,
        marketPrice: marketPrice ?? this.marketPrice,
        typeTrade: typeTrade ?? this.typeTrade,
        date: date ?? this.date,
      );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        id: json["id"],
        nameWalet: json["nameWalet"],
        symbol: json["symbol"],
        amount: json["amount"],
        marketPrice: json["marketPrice"],
        typeTrade: json["typeTrade"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameWalet": nameWalet,
        "symbol": symbol,
        "amount": amount,
        "marketPrice": marketPrice,
        "typeTrade": typeTrade,
        "date": date,
      };
}
