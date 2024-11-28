import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/wallet_model_test.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

part 'set_wallet_event.dart';
part 'set_wallet_state.dart';

class SetWalletBloc extends Bloc<SetWalletEvent, SetWalletState> {
  final FirebaseAuth _auth;
  late StreamSubscription _walletsSubscription;
  List fetchedWallets = [];
  bool executedCondition = false;

  SetWalletBloc(this._auth) : super(SetWalletInitial()) {
    on<Initial>(_initialize);
    on<ResetState>(_resetState);
    on<UpdateName>(_updateName);
    on<UpdateColor>(_updateColor);
    on<Create>(_createWallet);
    on<Update>(_updateWallet);
    on<Delete>(_deleteWallet);

    // Викликаємо _initialize в конструкторі
    add(Initial());
  }

  Future<void> _initialize(Initial event, Emitter<SetWalletState> emit) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        emit(state.copyWith(uid: user.uid));
        // Створюємо заготовлений Uuid для TotalWallet
        emit(state.copyWith(totalUuid: const Uuid().v4()));

        _walletsSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('wallets')
            .snapshots()
            .listen((docSnapshot) {
          fetchedWallets = docSnapshot.docs.map((doc) {
            return WalletEntity.fromDocument(doc.data());
          }).toList();
        }, onError: (error) {
          print('Error fetching wallets: $error');
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _resetState(ResetState event, Emitter<SetWalletState> emit) {
    print('ResetState event received with walletName: ${event.walletName}');
    emit(state.copyWith(
      walletColor: event.walletColor,
    ));
  }

  void _updateName(UpdateName event, Emitter<SetWalletState> emit) {
    emit(state.copyWith(walletName: event.newWalletName));
  }

  void _updateColor(UpdateColor event, Emitter<SetWalletState> emit) {
    print('new ${event.newWalletColor}');
    emit(state.copyWith(walletColor: event.newWalletColor));
  }

  Future<void> _createWallet(Create event, Emitter<SetWalletState> emit) async {
    final totalWallet = WalletModel(
      walletId: state.totalUuid,
      walletName: 'Total',
      walletColor: '#FFFFB300',
    );

    final newWallet = WalletModel(
      walletId: const Uuid().v4(),
      walletName: state.walletName,
      walletColor: state.walletColor,
    );

    print(fetchedWallets);

    try {
      if (fetchedWallets.length > 1 && !executedCondition) {
        // Створюєм загальний гаманець
        await FirebaseFirestore.instance
            .collection('users')
            .doc(state.uid)
            .collection('wallets')
            .doc(totalWallet.walletId) // Генеруємо ID
            .set(totalWallet.toJson());

        // Створюєм гаманець користувача
        await FirebaseFirestore.instance
            .collection('users')
            .doc(state.uid)
            .collection('wallets')
            .doc(newWallet.walletId) // Генеруємо ID
            .set(newWallet.toJson());

        //Білье не виконуєєм цю умову
        executedCondition = true;
      } else {
        // Створюєм гаманець користувача
        await FirebaseFirestore.instance
            .collection('users')
            .doc(state.uid)
            .collection('wallets')
            .doc(newWallet.walletId) // Генеруємо ID
            .set(newWallet.toJson());
      }
    } catch (e) {
      print('Error submitting wallets: $e');
    }
  }

  Future<void> _updateWallet(Update event, Emitter<SetWalletState> emit) async {
    try {
      final walletId = event.walletId;

      // Отримуємо посилання на документ гаманець в підколекції wallets
      final walletDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .doc(walletId);

      // Отримуємо дані документа
      final docSnapshot = await walletDoc.get();
      final currentData = docSnapshot.data();

      // Оновлюємо поля документа, зберігаючи поточні дані
      await walletDoc.set(
          {
            'walletName': event.newWalletName ?? currentData?['walletName'],
            'walletColor': event.newWalletColor ?? currentData?['walletColor'],
          },
          SetOptions(
              merge:
                  true)); // щоб оновити тільки вказані поля і залишити інші без змін.
    } catch (e) {
      print('Error updating wallet: $e');
    }
  }

  Future<void> _deleteWallet(Delete event, Emitter<SetWalletState> emit) async {
    try {
      final walletId = event.walletId;

      // Отримуємо посилання на документ гаманця в підколекції wallets
      final walletDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .doc(walletId);

      // Видаляємо документ гаманця
      await walletDoc.delete();

      // Отримуємо всі залишені гаманці після видалення
      final walletsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .get();

      // Створюємо список назв гаманців, які залишились
      final remainingWalletNames = walletsSnapshot.docs
          .map((doc) => doc.data()['walletId'] as String)
          .toList();

      // Отримуємо всі транзакції користувача
      final transactionsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('transactions');

      final transactionsSnapshot = await transactionsCollection.get();

      final batch = FirebaseFirestore.instance.batch();

      for (var transactionDoc in transactionsSnapshot.docs) {
        final walletNameInTransaction =
            transactionDoc.data()['walletId'] as String;

        // Якщо гаманця немає серед залишених, додаємо оновлення в batch
        if (!remainingWalletNames.contains(walletNameInTransaction)) {
          batch.update(transactionDoc.reference, {'walletId': null});
        }
      }

      // Виконуємо всі оновлення одним запитом
      await batch.commit();
    } catch (e) {
      print('Error deleting wallet: $e');
    }
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    return super.close();
  }
}
