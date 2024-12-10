class InfoForWalletModel {
  final String? walletId;
  final double totalWalletInvest;
  final double totalCurentSum;
  final double currentTotalProfitPercent;

  InfoForWalletModel({
    required this.walletId,
    this.totalWalletInvest = 0.00,
    this.totalCurentSum = 0.00,
    this.currentTotalProfitPercent = 0.00,
  });

  // Метод для конвертації JSON в модель
  factory InfoForWalletModel.fromJson(Map<String, dynamic> json) {
    return InfoForWalletModel(
      walletId: json['walletId'] as String,
      totalWalletInvest: json['totalWalletInvest'] as double,
      totalCurentSum: json['totalCurentSum'] as double,
      currentTotalProfitPercent: json['currentTotalProfitPercent'] as double,
    );
  }

  // Метод для конвертації моделі в JSON
  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'totalWalletInvest': totalWalletInvest,
      'totalCurentSum': totalCurentSum,
      'currentTotalProfitPercent': currentTotalProfitPercent,
    };
  }
}
