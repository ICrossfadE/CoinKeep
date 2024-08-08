import 'dart:convert';

TransactionsModel transactionsModelFromJson(String str) =>
    TransactionsModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionsModel data) =>
    json.encode(data.toJson());

class TransactionsModel {
  String? id;
  String? wallet;
  String? type;
  String? symbol;
  String? icon;
  int? price;
  int? amount;
  String? date;

  TransactionsModel({
    this.id,
    this.wallet,
    this.type,
    this.symbol,
    this.icon,
    this.price,
    this.amount,
    this.date,
  });

  TransactionsModel copyWith({
    String? id,
    String? wallet,
    String? type,
    String? symbol,
    String? icon,
    int? price,
    int? amount,
    String? date,
  }) =>
      TransactionsModel(
        id: id ?? this.id,
        wallet: wallet ?? this.wallet,
        type: type ?? this.type,
        symbol: symbol ?? this.symbol,
        icon: icon ?? this.icon,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        id: json["id"],
        wallet: json["wallet"],
        type: json["type"],
        symbol: json["symbol"],
        icon: json["icon"],
        price: json['price'],
        amount: json["amount"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wallet": wallet,
        "type": type,
        "symbol": symbol,
        "icon": icon,
        "price": price,
        "amount": amount,
        "date": date,
      };
}
