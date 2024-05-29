import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, int> {
  // constructor
  CounterBloc() : super(5) {
    on<IncrementEvent>(_onIncrement);
    on<DecrementEvent>(_onDecrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<int> emit) {
    emit(state + 1);
  }

  void _onDecrement(DecrementEvent event, Emitter<int> emit) {
    emit(state - 1);
  }
}

// Events
abstract class CounterEvents {}

class IncrementEvent extends CounterEvents {}

class DecrementEvent extends CounterEvents {}
