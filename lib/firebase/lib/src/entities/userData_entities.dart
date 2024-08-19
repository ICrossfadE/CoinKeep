import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';
import 'package:equatable/equatable.dart';

import '../models/wallet_model_test.dart';

class UserDataEntity extends Equatable {
  final String userId;
  final List<WalletModel>? wallets;
  final List<TransactionsModel>? transactions;

  const UserDataEntity({
    required this.userId,
    this.wallets,
    this.transactions,
  });
  // Перетворюємо в JSON для відправки у Firestore
  Map<String, Object?> toDocument() {
    return {
      'wallets': wallets?.map((wallet) => wallet.toJson()).toList(),
      'transactions':
          transactions?.map((transaction) => transaction.toJson()).toList(),
    };
  }

  // Відновлення UserDataEntity з Map
  static UserDataEntity fromDocument(Map<String, dynamic> document) {
    return UserDataEntity(
      userId: document['userId'] as String,
      wallets: (document['wallets'] as List<dynamic>?)
          ?.map((item) => WalletModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      transactions: (document['transactions'] as List<dynamic>?)
          ?.map((item) =>
              TransactionsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [userId, wallets, transactions];
}
