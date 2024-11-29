class WalletEntity {
  String? walletId;
  String walletName;
  String? walletColor;

  WalletEntity({
    this.walletId,
    this.walletName = '',
    this.walletColor,
  });

  WalletEntity copyWith({
    String? walletId,
    String? walletName,
    String? walletColor,
  }) {
    return WalletEntity(
      walletId: walletId ?? this.walletId,
      walletName: walletName ?? this.walletName,
      walletColor: walletColor ?? this.walletColor,
    );
  }

  static WalletEntity fromDocument(Map<String, dynamic> json) {
    return WalletEntity(
      walletId: json["walletId"],
      walletName: json["walletName"],
      walletColor: json["walletColor"],
    );
  }

  Map<String, dynamic> toDocument() => {
        "walletId": walletId,
        "walletName": walletName,
        "walletColor": walletColor,
      };
}
