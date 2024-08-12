import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/models/transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_transactions_state.dart';

class GetTransactionsCubit extends Cubit<List<TransactionsModel>> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  late StreamSubscription _transactionsSubscription;

  GetTransactionsCubit(
    this._auth,
    this._firestore,
  ) : super([]) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        final data = docSnapshot.data();
        final transactionsData = data?['transactions'] as List<dynamic>?;

        if (transactionsData != null) {
          final transactions = transactionsData.map((item) {
            return TransactionsModel.fromJson(item as Map<String, dynamic>);
          }).toList();

          emit(transactions);
          print(transactions);
        } else {
          print('No transactions found.');
        }
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    return super.close();
  }
}

// print('Користувач автентифікований: ${user.uid}');
//         _transactionsSubscription = _firestore
//             .collection('users')
//             .doc(user.uid)
//             .collection('transactions')
//             .snapshots()
//             .listen((snapshot) {
//           print('Шлях запиту: users/${user.uid}/transactions');
//           print('Метадані знімку: ${snapshot.metadata}');
//           print('Розмір знімку: ${snapshot.size}');
//           print(
//               'Документи знімку: ${snapshot.docs.map((doc) => doc.id).join(', ')}');
//           final transactions = snapshot.docs.map((doc) {
//             return TransactionsModel.fromJson(doc.data());
//           }).toList();
//           emit(GetTransactionsLoaded(transactions));
//           print('data ${GetTransactionsLoaded(transactions)}');
//         }, onError: (error) {
//           print('Error in snapshot listener: $error');
//         });