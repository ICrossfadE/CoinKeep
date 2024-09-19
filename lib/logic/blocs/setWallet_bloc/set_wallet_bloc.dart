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
      final newWallet = WalletModel(
        walletId: const Uuid().v4(),
        walletName: state.walletName,
        walletColor: state.walletColor,
      );

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

      // Отримуємо посилання на документ гаманець в підколекції wallets
      final walletDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(state.uid)
          .collection('wallets')
          .doc(walletId);

      // Видаляємо документ
      await walletDoc.delete();
    } catch (e) {
      print('Error deleting wallet: $e');
    }
  }

  // Future<void> _deleteWalletAndUpdateTransactions(
  //     Delete event, Emitter<SetWalletState> emit) async {
  //   try {
  //     final walletId = event.walletId;

  //     // Видаляємо кошельок
  //     final userDoc =
  //         FirebaseFirestore.instance.collection('users').doc(state.uid);
  //     final userSnapshot = await userDoc.get();
  //     final wallets = List<Map<String, dynamic>>.from(
  //         userSnapshot.data()?['wallets'] ?? []);
  //     final updatedWallets =
  //         wallets.where((wallet) => wallet['walletId'] != walletId).toList();

  //     // final batch = FirebaseFirestore.instance.batch();

  //     await userDoc.update({
  //       'wallets': updatedWallets,
  //     });

  //     // // Отримання документу користувача
  //     // final userDocSnapshot = await FirebaseFirestore.instance
  //     //     .collection('users')
  //     //     .doc(state.uid)
  //     //     .get();

  //     // if (userDocSnapshot.exists) {
  //     //   final userData = userDocSnapshot.data();
  //     //   if (userData != null && userData.containsKey('wallets')) {
  //     //     final walletsData =
  //     //         List<Map<String, dynamic>>.from(userData['wallets']);
  //     //     final walletNames = walletsData
  //     //         .map((wallet) => wallet['walletName'] as String)
  //     //         .toList();

  //     //     print('Available wallet names: $walletNames');
  //     //   } else {
  //     //     print('No wallets field found.');
  //     //   }
  //     // } else {
  //     //   print('User document does not exist.');
  //     // }

  //     // Виконуємо batch-оновлення
  //     // await batch.commit();
  //   } catch (e) {
  //     print('Error deleting wallet and updating transactions: $e');
  //   }
  // }
}
