import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:CoinKeep/data/coin_model.dart';
import 'package:CoinKeep/resource/api_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {
    on<GetCoins>(_onGetCoins);
  }

  final ApiRepository _apiRepository = ApiRepository();

  void _onGetCoins(GetCoins event, Emitter<TransactionsState> emit) async {
    try {
      emit(TransactionsLoading());
      final coinList = await _apiRepository.fetchCoins();
      emit(TransactionsLoaded(coinList));
      if (coinList.error != null) {
        emit(TransactionsError(coinList.error));
      }
    } on NetworkError {
      emit(TransactionsError('Failed to fetch data. is your device online?'));
    }
  }
}
