import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TransactionsModel transactionsModelFromJson(String str) =>
    TransactionsModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionsModel data) =>
    json.encode(data.toJson());

class TransactionsModel {
  String? id;
  String? wallet;
  String? type;
  String? name;
  String? symbol;
  int? icon;
  double? price;
  double? amount;
  DateTime? date;

  TransactionsModel({
    this.id,
    this.wallet,
    this.type,
    this.name,
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
    String? name,
    String? symbol,
    int? icon,
    double? price,
    double? amount,
    DateTime? date,
  }) =>
      TransactionsModel(
        id: id ?? this.id,
        wallet: wallet ?? this.wallet,
        type: type ?? this.type,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        icon: icon ?? this.icon,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      id: json["id"],
      wallet: json["wallet"],
      type: json["type"],
      name: json['name'],
      symbol: json["symbol"],
      icon: json["icon"],
      price: json['price']?.toDouble(), // Додаємо .toDouble() для безпеки
      amount: json["amount"]?.toDouble(), // Додаємо .toDouble() для безпеки
      date: json["date"] is Timestamp
          ? (json["date"] as Timestamp).toDate()
          : null, // Перетворюємо Timestamp в DateTime
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "wallet": wallet,
        "type": type,
        "name": name,
        "symbol": symbol,
        "icon": icon,
        "price": price,
        "amount": amount,
        "date": date?.toIso8601String(), // Перетворюємо DateTime в ISO рядок
      };
}
