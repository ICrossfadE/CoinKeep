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

  TransactionBloc(this._auth) : super(TransactionInitial()) {
    on<Initial>(_initialize);
    on<ResetState>(_resetState);
    on<UpdateIcon>(_updateIcon);
    on<UpdateDate>(_updateDate);
    on<UpdateTrade>(_updateTrade);
    on<UpdateSymbol>(_updateSymbol);
    on<UpdateWallet>(_updateWallet);
    on<UpdatePriceValue>(_updatePrice);
    on<UpdateAmountValue>(_updateAmount);
    on<Update>(_updateTransaction);
    on<Create>(_createTransaction);
    on<Delete>(_deleteTransaction);

    // Викликаємо _initialize в конструкторі
    add(Initial());
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

  void _resetState(ResetState event, Emitter<TransactionState> emit) {
    emit(state.copyWith(
      date: event.date,
      price: event.price,
      amount: event.amount,
      selectedWallet: event.selectedWallet,
      typeTrade: event.typeTrade,
    ));
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

  void _updateIcon(UpdateIcon event, Emitter<TransactionState> emit) {
    emit(state.copyWith(iconId: event.iconId));
  }

  void _updateSymbol(UpdateSymbol event, Emitter<TransactionState> emit) {
    emit(state.copyWith(symbol: event.symbol));
  }

  void _updateDate(UpdateDate event, Emitter<TransactionState> emit) {
    emit(state.copyWith(date: event.newDate));
  }

  void _updateTrade(UpdateTrade event, Emitter<TransactionState> emit) {
    emit(state.copyWith(typeTrade: event.newTypeTraide));
  }

  Future<void> _createTransaction(
      Create event, Emitter<TransactionState> emit) async {
    try {
      final newTransaction = TransactionsModel(
        id: const Uuid().v4(),
        wallet: state.selectedWallet,
        type: state.typeTrade,
        symbol: state.symbol,
        icon: state.iconId,
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

  Future<void> _updateTransaction(
      Update event, Emitter<TransactionState> emit) async {
    try {
      final transactionId = event.transactionId;

      // Отримуємо посилання на документ користувача
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(state.uid);
      final userSnapshot = await userDoc.get();
      final transactions = List<Map<String, dynamic>>.from(
          userSnapshot.data()?['transactions'] ?? []);

      // Знаходимо транзакцію за її ID та оновлюємо поля
      final updatedTransactions = transactions.map((transaction) {
        if (transaction['id'] == transactionId) {
          return {
            ...transaction,
            'wallet': event.newWallet ?? transaction['wallet'],
            'type': event.newTypeTrade ?? transaction['type'],
            'price': event.newTypeTrade == "SELL"
                ? -event.newPrice!
                : event.newPrice ?? transaction['price'],
            'amount': event.newAmount ?? transaction['amount'],
            'date': event.newDate?.toIso8601String() ?? transaction['date'],
          };
        }
        return transaction;
      }).toList();

      // Оновлюємо транзакції в Firestore
      await userDoc.update({
        'transactions': updatedTransactions,
      });

      // emit(state.copyWith(transactions: updatedTransactions));
    } catch (e) {
      print('Error updating transaction: $e');
    }
  }

  Future<void> _deleteTransaction(
      Delete event, Emitter<TransactionState> emit) async {
    try {
      final transactionId = event.transactionId;

      // Отримуємо поточний список транзакцій користувача
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(state.uid);
      final userSnapshot = await userDoc.get();
      final transactions = List<Map<String, dynamic>>.from(
          userSnapshot.data()?['transactions'] ?? []);

      // Фільтруємо список для видалення транзакції
      final updatedTransactions = transactions
          .where((transaction) => transaction['id'] != transactionId)
          .toList();

      // Оновлюємо колекцію користувача новим списком транзакцій
      await userDoc.update({
        'transactions': updatedTransactions,
      });

      // emit(state.copyWith(transactions: updatedTransactions));
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }
}
