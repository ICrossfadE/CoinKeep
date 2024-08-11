import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../../firebase/lib/src/models/transaction.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final String symbol;
  final int iconId;

  TransactionCubit(
    this._auth,
    this._firestore,
    this.symbol,
    this.iconId,
  ) : super(TransactionInitial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final User? user = await _auth.currentUser;
      if (user != null) {
        emit(state.copyWith(uid: user.uid));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitTransaction() async {
    final newTransaction = TransactionsModel(
      id: const Uuid().v4(), // uid це ваш ідентифікатор
      wallet: state.selectedWallet,
      type: state.typeTrade,
      symbol: symbol,
      icon: iconId,
      price: state.price,
      amount: state.amount, // Приклад суми
      date: state.date, // Поточна дата
    );

    await _firestore.collection('users').doc(state.uid).update({
      'transactions': FieldValue.arrayUnion([newTransaction.toJson()])
    });
  }

  void updateWallet(String wallet) {
    emit(state.copyWith(selectedWallet: wallet));
  }

  void updatePrice(String value) {
    try {
      final price = double.parse(value);
      emit(state.copyWith(price: price));
      print('price ${state.price}');
    } catch (e) {
      print('Invalid price input: $value');
      // Можна також показати користувачеві повідомлення про помилку
    }
  }

  void updateAmount(String value) {
    try {
      final amount = double.parse(value);
      emit(state.copyWith(amount: amount));
      print('amount ${state.amount}');
    } catch (e) {
      print('Invalid amount input: $value');
      // Можна також показати користувачеві повідомлення про помилку
    }
  }

  void updateSum() {
    final double price = state.price ?? 0;
    final double amount = state.amount ?? 0;
    emit(state.copyWith(sum: price * amount));
  }

  void updateDate(DateTime picked) {
    emit(state.copyWith(date: picked));
  }

  void chngeTrade(String type) {
    emit(state.copyWith(typeTrade: type));
  }
}
