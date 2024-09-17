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
    try {
      final newTransaction = WalletModel(
        walletId: const Uuid().v4(),
        walletName: state.walletName,
        walletColor: state.walletColor,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .update({
        'wallets': FieldValue.arrayUnion([newTransaction.toJson()])
      });
    } catch (e) {
      print('Error submitting wallets: $e');
    }
  }

  Future<void> _updateWallet(Update event, Emitter<SetWalletState> emit) async {
    try {
      final walletId = event.walletId;

      // Отримуємо посилання на документ користувача
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(state.uid);
      final userSnapshot = await userDoc.get();
      final wallets = List<Map<String, dynamic>>.from(
          userSnapshot.data()?['wallets'] ?? []);

      // Знаходимо Wallet за її ID та оновлюємо поля
      final updatedWallets = wallets.map((wallet) {
        if (wallet['walletId'] == walletId) {
          return {
            ...wallet,
            'walletName': event.newWalletName ?? wallet['walletName'],
            'walletColor': event.newWalletColor ?? wallet['walletColor'],
          };
        }
        return wallet;
      }).toList();

      // Оновлюємо wallet в Firestore
      await userDoc.update({
        'wallets': updatedWallets,
      });

      // emit(state.copyWith(updatedWallets: updatedWallets));
    } catch (e) {
      print('Error updating wallets: $e');
    }
  }

  Future<void> _deleteWallet(Delete event, Emitter<SetWalletState> emit) async {
    try {
      final walletId = event.walletId;

      // Отримуємо поточний список wallets користувача
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(state.uid);
      final userSnapshot = await userDoc.get();
      final wallets = List<Map<String, dynamic>>.from(
          userSnapshot.data()?['wallets'] ?? []);

      // Фільтруємо список для видалення wallets
      final updatedWallets =
          wallets.where((wallet) => wallet['walletId'] != walletId).toList();

      // Оновлюємо колекцію користувача новим списком wallets
      await userDoc.update({
        'wallets': updatedWallets,
      });
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }
}
