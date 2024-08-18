import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/models/asset_model.dart';
import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_transactions_state.dart';

class GetTransactionsCubit extends Cubit<TransactionState> {
  final FirebaseAuth _auth;
  late StreamSubscription _transactionsSubscription;

  GetTransactionsCubit(this._auth)
      : super(const TransactionState(transactions: [])) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        _transactionsSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((docSnapshot) {
          final data = docSnapshot.data();
          final transactionsData = data?['transactions'] as List<dynamic>?;

          if (transactionsData != null) {
            final transactions = transactionsData.map((item) {
              return TransactionsModel.fromJson(item as Map<String, dynamic>);
            }).toList();

            emit(state.copyWith(transactions: transactions));
          } else {
            print('No transactions found.');
          }
        }, onError: (error) {
          print('Error fetching transactions: $error');
        });
      }
    } catch (e) {
      print('Error initializing transactions listener: $e');
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    return super.close();
  }
}
