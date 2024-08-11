import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../../firebase/lib/src/models/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final String symbol;
  final int iconId;

  TransactionBloc(
    this._auth,
    this._firestore,
    this.symbol,
    this.iconId,
  ) : super(TransactionInitial()) {
    // _initialize();
    on<Initial>(_initialize);
    on<UpdateDate>(_updateDate);
    on<UpdateTrade>(_updateTrade);
    on<UpdateWallet>(_updateWallet);
    on<UpdatePriceValue>(_updatePrice);
    on<UpdateAmountValue>(_updateAmount);
    on<Submit>(_submitTransaction);
  }

  Future<void> _initialize(
      Initial event, Emitter<TransactionState> emit) async {
    try {
      final User? user = await _auth.currentUser;
      if (user != null) {
        emit(state.copyWith(uid: user.uid));
      }
    } catch (e) {
      print(e);
    }
  }

  void _updatePrice(UpdatePriceValue event, Emitter<TransactionState> emit) {
    final newPrice = event.newPrice;
    final newSum = newPrice * state.amount;
    print('new value ${newPrice}');
    emit(state.copyWith(
      price: newPrice,
      sum: newSum,
    ));
  }

  void _updateAmount(UpdateAmountValue event, Emitter<TransactionState> emit) {
    final newAmount = event.newAmount;
    final newSum = state.price * newAmount;

    emit(state.copyWith(
      amount: newAmount,
      sum: newSum,
    ));
  }

  void _updateWallet(UpdateWallet event, Emitter<TransactionState> emit) {
    emit(state.copyWith(selectedWallet: event.newWallet));
  }

  void _updateDate(UpdateDate event, Emitter<TransactionState> emit) {
    print('new value ${event.newDate}');
    emit(state.copyWith(date: event.newDate));
  }

  void _updateTrade(UpdateTrade event, Emitter<TransactionState> emit) {
    print('new value ${event.newTypeTraide}');
    emit(state.copyWith(typeTrade: event.newTypeTraide));
  }

  Future<void> _submitTransaction(
      Submit event, Emitter<TransactionState> emit) async {
    try {
      final newTransaction = TransactionsModel(
        id: const Uuid().v4(),
        wallet: state.selectedWallet,
        type: state.typeTrade,
        symbol: symbol,
        icon: iconId,
        price: state.price,
        amount: state.amount,
        date: state.date,
      );

      await _firestore.collection('users').doc(state.uid).update({
        'transactions': FieldValue.arrayUnion([newTransaction.toJson()])
      });
      // Можливо, варто додати повідомлення про успішне завершення
    } catch (e) {
      print('Error submitting transaction: $e');
      // Тут можна додати логіку для обробки помилок
    }
  }
}
