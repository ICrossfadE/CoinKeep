class WalletModel {
  String? walletId;
  String? walletName;
  String? walletColor;

  WalletModel({
    this.walletId,
    this.walletName,
    this.walletColor,
  });

  WalletModel copyWith({
    String? walletId,
    String? walletName,
    String? walletColor,
  }) {
    return WalletModel(
      walletId: walletId ?? this.walletId,
      walletName: walletName ?? this.walletName,
      walletColor: walletColor ?? this.walletColor,
    );
  }

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      walletId: json["walletId"],
      walletName: json["walletName"],
      walletColor: json["walletColor"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "walletId": walletId,
      "walletName": walletName,
      "walletColor": walletColor,
    };
  }
}
