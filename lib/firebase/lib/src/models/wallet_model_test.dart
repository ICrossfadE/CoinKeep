class WalletModel {
  String? id;
  String? name;
  String? color;
  int? profit;

  WalletModel({
    this.id,
    this.name,
    this.color,
    this.profit,
  });

  WalletModel copyWith({
    String? id,
    String? name,
    String? color,
    int? profit,
  }) {
    return WalletModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      profit: profit ?? this.profit,
    );
  }

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json["id"],
      name: json["name"],
      color: json["color"],
      profit: json["profit"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color,
      "profit": profit,
    };
  }
}
