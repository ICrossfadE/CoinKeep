import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_wallet_state.dart';

class GetWalletCubit extends Cubit<GetWalletState> {
  final FirebaseAuth _auth;
  final SetWalletBloc _setWalletBloc;
  late StreamSubscription _walletsSubscription;

  GetWalletCubit(
    this._auth,
    this._setWalletBloc,
  ) : super(const GetWalletState(wallets: [])) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        // Підписка на зміни в підколекції wallets
        _walletsSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('wallets')
            .snapshots()
            .listen((docSnapshot) async {
          // Отримуємо гаманці з Firestore
          final walletsFromFirebase = docSnapshot.docs.map((doc) {
            return WalletEntity.fromDocument(doc.data());
          }).toList();

          final filteredWallets = walletsFromFirebase
              .where(
                  (wallet) => wallet.walletId != _setWalletBloc.state.totalUuid)
              .toList();

          emit(state.copyWith(
            wallets: walletsFromFirebase,
            filteredWallets: filteredWallets,
          ));
        }, onError: (error) {
          print('Error fetching wallets: $error');
        });
      }
    } catch (e) {
      print('Error initializing wallets listener: $e');
    }
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    return super.close();
  }
}
