import 'package:CoinKeep/firebase/lib/src/entities/userData_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';
import 'package:CoinKeep/firebase/lib/src/models/wallet_model_test.dart';

class UserDataModel {
  final String userId;
  final List<WalletModel>? wallets;
  final List<TransactionsModel>? transactions;

  const UserDataModel({
    required this.userId,
    this.wallets,
    this.transactions,
  });

  // Перетворення UserDataModel в Map для збереження у Firestore
  Map<String, dynamic> toJson() {
    return {
      'wallets': wallets,
      'transactions': transactions,
    };
  }

  // Статичний екземпляр порожньх данних
  static UserDataModel empty = const UserDataModel(
    userId: '',
    wallets: [],
    transactions: [],
  );

  // Метод копіювання для оновлення
  UserDataModel copyWith({
    List<WalletModel>? wallets,
    List<TransactionsModel>? transactions,
  }) {
    return UserDataModel(
      userId: userId,
      wallets: wallets ?? this.wallets,
      transactions: transactions ?? this.transactions,
    );
  }

  UserDataModel toEntity() {
    return UserDataModel(
      userId: userId,
      wallets: wallets,
      transactions: transactions,
    );
  }

  static UserDataModel fromEntity(UserDataEntity entity) {
    return UserDataModel(
      userId: entity.userId,
      wallets: entity.wallets,
      transactions: entity.transactions,
    );
  }
}
