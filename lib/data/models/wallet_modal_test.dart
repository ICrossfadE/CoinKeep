import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
  List<WalletElement> wallets;

  Wallet({
    required this.wallets,
  });

  Wallet copyWith({
    List<WalletElement>? wallets,
  }) =>
      Wallet(
        wallets: wallets ?? this.wallets,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        wallets: List<WalletElement>.from(
            json["wallets"].map((x) => WalletElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wallets": List<dynamic>.from(wallets.map((x) => x.toJson())),
      };
}

class WalletElement {
  String id;
  String name;
  String color;
  int profit;
  List<dynamic> transactions;

  WalletElement({
    required this.id,
    required this.name,
    required this.color,
    required this.profit,
    required this.transactions,
  });

  WalletElement copyWith({
    String? id,
    String? name,
    String? color,
    int? profit,
    List<dynamic>? transactions,
  }) =>
      WalletElement(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        profit: profit ?? this.profit,
        transactions: transactions ?? this.transactions,
      );

  factory WalletElement.fromJson(Map<String, dynamic> json) => WalletElement(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        profit: json["profit"],
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "profit": profit,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
      };
}
