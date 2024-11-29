part of 'set_wallet_bloc.dart';

class SetWalletState extends Equatable {
  final String uid;
  final String walletName;
  final String walletColor;
  final String totalUuid;

  const SetWalletState({
    this.uid = '',
    this.walletName = '',
    this.walletColor = '#FFFDD835',
    this.totalUuid = '',
  });

  SetWalletState copyWith({
    String? uid,
    String? walletName,
    String? walletColor,
    String? totalUuid,
  }) {
    return SetWalletState(
        uid: uid ?? this.uid,
        walletName: walletName ?? this.walletName,
        walletColor: walletColor ?? this.walletColor,
        totalUuid: totalUuid ?? this.totalUuid);
  }

  factory SetWalletState.fromMap(Map<String, dynamic> map) {
    return SetWalletState(
      uid: map['uid'] ?? '',
      walletName: map['walletName'] ?? '',
      walletColor: map['walletColor'] ?? '',
      totalUuid: map['totalUuid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'walletName': walletName,
      'walletColor': walletColor,
      'totalUuid': totalUuid,
    };
  }

  @override
  List<Object> get props => [
        uid,
        walletName,
        walletColor,
        totalUuid,
      ];
}

final class SetWalletInitial extends SetWalletState {}
