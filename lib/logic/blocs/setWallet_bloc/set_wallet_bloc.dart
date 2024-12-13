import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/firebase/lib/src/models/wallet_model_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';

part 'set_wallet_event.dart';
part 'set_wallet_state.dart';

class SetWalletBloc extends HydratedBloc<SetWalletEvent, SetWalletState> {
  final FirebaseAuth _auth;
  StreamSubscription? _walletsSubscription;
  List<WalletEntity> fetchedWallets = [];
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

        if (state.totalUuid.isEmpty) {
          final String generatedUuid = const Uuid().v4();
          emit(state.copyWith(totalUuid: generatedUuid));
          print('First wallet created = ${state.totalUuid}');
        }

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
      print('Error during initialization: $e');
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
    // Гаманець користувача
    final newWallet = WalletModel(
      walletId: const Uuid().v4(),
      walletName: state.walletName,
      walletColor: state.walletColor,
    );

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .doc(newWallet.walletId) // Генеруємо ID
          .set(newWallet.toJson());
    } catch (e) {
      print('Error submitting wallets: $e');
    }
  }

  Future<void> _updateWallet(Update event, Emitter<SetWalletState> emit) async {
    final walletId = event.walletId;

    try {
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
      await walletDoc.set({
        'walletName': event.newWalletName ?? currentData?['walletName'],
        'walletColor': event.newWalletColor ?? currentData?['walletColor'],
      }, SetOptions(merge: true));
      // щоб оновити тільки вказані поля і залишити інші без змін.
    } catch (e) {
      print('Error updating wallet: $e');
    }
  }

  Future<void> _deleteWallet(Delete event, Emitter<SetWalletState> emit) async {
    final walletId = event.walletId;

    try {
      // Видаляємо вказаний гаманець
      final walletDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .doc(walletId);

      await walletDoc.delete();

      // Отримуємо оновлений список гаманців
      final walletsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .get();

      // Отримуєм снепшот гаманців після видалення
      final remainingWallets = walletsSnapshot.docs;

      // Оновлюємо транзакції, якщо їх гаманець було видалено
      final remainingWalletIds = remainingWallets
          .map((doc) => doc.data()['walletId'] as String)
          .toList();

      final transactionsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('transactions');

      final transactionsSnapshot = await transactionsCollection.get();

      final batch = FirebaseFirestore.instance.batch();

      for (var transactionDoc in transactionsSnapshot.docs) {
        final walletIdInTransaction =
            transactionDoc.data()['walletId'] as String;

        // Якщо гаманець більше не існує, оновлюємо відповідну транзакцію
        if (!remainingWalletIds.contains(walletIdInTransaction)) {
          batch.update(transactionDoc.reference, {'walletId': null});
        }
      }

      // Виконуємо всі оновлення
      await batch.commit();
    } catch (e) {
      print('Error deleting wallet: $e');
    }
  }

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    return super.close();
  }

  @override
  SetWalletState? fromJson(Map<String, dynamic> json) {
    try {
      return SetWalletState.fromMap(json);
    } catch (e) {
      print('Error restoring state: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SetWalletState state) {
    try {
      return state.toMap();
    } catch (e) {
      print('Error saving state: $e');
      return null;
    }
  }
}
