import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  UserAuthBloc() : super(UserAuthInitial()) {
    on<UserAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
