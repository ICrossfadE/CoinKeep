import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_wallet_state.dart';

class GetWalletCubit extends Cubit<GetWalletState> {
  GetWalletCubit() : super(GetWalletInitial());
}
