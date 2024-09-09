part of 'get_wallet_cubit.dart';

sealed class GetWalletState extends Equatable {
  const GetWalletState();

  @override
  List<Object> get props => [];
}

final class GetWalletInitial extends GetWalletState {}
