class TransactionEntity {
  double? amount;
  DateTime? date;
  int? icon;
  String? id;
  double? price;
  String? symbol;
  String? type;
  String? wallet;

  TransactionEntity({
    this.amount,
    this.date,
    this.icon,
    this.id,
    this.price,
    this.symbol,
    this.type,
    this.wallet,
  });

  TransactionEntity copyWith({
    double? amount,
    DateTime? date,
    int? icon,
    String? id,
    double? price,
    String? symbol,
    String? type,
    String? wallet,
  }) =>
      TransactionEntity(
        amount: amount ?? this.amount,
        date: date ?? this.date,
        icon: icon ?? this.icon,
        id: id ?? this.id,
        price: price ?? this.price,
        symbol: symbol ?? this.symbol,
        type: type ?? this.type,
        wallet: wallet ?? this.wallet,
      );

  static TransactionEntity fromDocument(Map<String, dynamic> json) {
    return TransactionEntity(
      amount: json["amount"]?.toDouble(),
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
      icon: json["icon"],
      id: json["id"],
      price: json['price']?.toDouble(),
      symbol: json["symbol"],
      type: json["type"],
      wallet: json["wallet"],
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
        "type": type,
        "wallet": wallet,
      };
}
