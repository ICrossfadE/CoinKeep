import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/entities/wallet_entities.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_wallet_state.dart';

class GetWalletCubit extends Cubit<GetWalletState> {
  final FirebaseAuth _auth;
  late StreamSubscription _walletsSubscription;

  GetWalletCubit(this._auth) : super(const GetWalletState(wallets: [])) {
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
            .listen((querySnapshot) {
          final wallets = querySnapshot.docs.map((doc) {
            return WalletEntity.fromDocument(doc.data());
          }).toList();

          emit(state.copyWith(wallets: wallets));
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
