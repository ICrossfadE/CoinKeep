class TransactionEntity {
  double? amount;
  DateTime? date;
  int? icon;
  String? id;
  double? price;
  String? symbol;
  String? name;
  String? type;
  String? walletId;

  TransactionEntity({
    this.amount,
    this.date,
    this.icon,
    this.id,
    this.price,
    this.symbol,
    this.name,
    this.type,
    this.walletId,
  });

  TransactionEntity copyWith({
    double? amount,
    DateTime? date,
    int? icon,
    String? id,
    double? price,
    String? symbol,
    String? name,
    String? type,
    String? walletId,
  }) =>
      TransactionEntity(
        amount: amount ?? this.amount,
        date: date ?? this.date,
        icon: icon ?? this.icon,
        id: id ?? this.id,
        price: price ?? this.price,
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        type: type ?? this.type,
        walletId: walletId ?? this.walletId,
      );

  static TransactionEntity fromDocument(Map<String, dynamic> json) {
    return TransactionEntity(
      amount: json["amount"]?.toDouble(),
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
      icon: json["icon"],
      id: json["id"],
      price: json['price']?.toDouble(),
      symbol: json["symbol"],
      name: json["name"],
      type: json["type"],
      walletId: json["walletId"],
    );
  }

  // Перетворюємо в обєкт з Firestore

  Map<String, dynamic> toDocument() => {
        "amount": amount,
        "date": date?.toIso8601String(),
        "icon": icon,
        "id": id,
        "price": price,
        "symbol": symbol,
        "name": name,
        "type": type,
        "walletId": walletId,
      };
}
