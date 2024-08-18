import 'package:CoinKeep/firebase/lib/src/models/transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FirebaseAuth _auth;
  final String symbol;
  final int iconId;

  TransactionBloc(
    this._auth,
    this.symbol,
    this.iconId,
  ) : super(TransactionInitial()) {
    on<Initial>(_initialize);
    on<UpdateDate>(_updateDate);
    on<UpdateTrade>(_updateTrade);
    on<UpdateWallet>(_updateWallet);
    on<UpdatePriceValue>(_updatePrice);
    on<UpdateAmountValue>(_updateAmount);
    on<Submit>(_submitTransaction);

    // Викликаємо _initialize в конструкторі
    add(const Initial());
  }

  Future<void> _initialize(
      Initial event, Emitter<TransactionState> emit) async {
    try {
      final User? user = _auth.currentUser;
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
    emit(state.copyWith(date: event.newDate));
  }

  void _updateTrade(UpdateTrade event, Emitter<TransactionState> emit) {
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
        price: state.typeTrade == "SELL" ? -state.price : state.price,
        amount: state.amount,
        date: state.date,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .update({
        'transactions': FieldValue.arrayUnion([newTransaction.toJson()])
      });
    } catch (e) {
      print('Error submitting transaction: $e');
    }
  }
}
