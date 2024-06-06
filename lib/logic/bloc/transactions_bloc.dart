import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:CoinKeep/data/repositories/api_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {
    on<GetCoins>(_onGetCoins);
    on<SearchCoins>(_onSearchCoins);
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

// test
  void _onSearchCoins(
      SearchCoins event, Emitter<TransactionsState> emit) async {
    try {
      emit(TransactionsLoading());
      final coinList = await _apiRepository.searchCoins(event.query);
      emit(TransactionsLoaded(coinList));
      if (coinList.error != null) {
        emit(TransactionsError(coinList.error));
      }
    } on NetworkError {
      emit(TransactionsError('Failed to fetch data. is your device online?'));
    }
  }
}
