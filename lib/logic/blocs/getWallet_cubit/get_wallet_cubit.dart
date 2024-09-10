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
        _walletsSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((docSnapshot) {
          final data = docSnapshot.data();
          final walletsData = data?['wallets'] as List<dynamic>?;

          if (walletsData != null) {
            final wallets = walletsData.map((item) {
              return WalletEntity.fromDocument(item as Map<String, dynamic>);
            }).toList();

            emit(state.copyWith(wallets: wallets));
          } else {
            print('No wallets found.');
          }
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