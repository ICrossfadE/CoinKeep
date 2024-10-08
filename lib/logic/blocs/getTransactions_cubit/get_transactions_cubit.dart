import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/transaction_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/asset_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_transactions_state.dart';

class GetTransactionsCubit extends Cubit<GetTransactionsState> {
  final FirebaseAuth _auth;
  late StreamSubscription _transactionsSubscription;

  GetTransactionsCubit(this._auth)
      : super(const GetTransactionsState(transactions: [])) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        _transactionsSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('transactions')
            .snapshots()
            .listen((docSnapshot) {
          final transactions = docSnapshot.docs.map((doc) {
            return TransactionEntity.fromDocument(doc.data());
          }).toList();

          transactions.sort((b, a) => a.date!.compareTo(b.date!));

          emit(state.copyWith(transactions: transactions));
        }, onError: (error) {
          print('Error fetching transactions: $error');
        });
      }
    } catch (e) {
      print('Error initializing transactions listener: $e');
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final transactionDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('transactions')
            .doc(transactionId);

        // Видаляємо документ
        await transactionDoc.delete();

        final updatedTransactions = state.transactions
            .where((transaction) => transaction.id != transactionId)
            .toList();

        emit(state.copyWith(transactions: updatedTransactions));
        // Після видалення Firestore автоматично оновить поток даних,
        // і ваш Cubit отримає новий список транзакцій.
      }
    } catch (e) {
      print('Error deleting transaction: $e');
      // Можна обробити помилку, якщо потрібно
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    return super.close();
  }
}
