import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/authRepository.dart';
import 'package:CoinKeep/firebase/lib/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_google_event.dart';
part 'auth_google_state.dart';

class AuthGoogleBloc extends Bloc<AuthGoogleEvent, AuthGoogleState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthRepository get authRepository => _authRepository;

  AuthGoogleBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthGoogleState.unknown()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) {
        print(
            'User state changed: ${user != null ? 'Authenticated' : 'Unauthenticated'}');
        add(AppUserChanged(user));
      },
    );
  }

  void _onUserChanged(AppUserChanged event, Emitter<AuthGoogleState> emit) {
    if (event.user != null) {
      emit(AuthGoogleState.authenticated(event.user!));
    } else {
      emit(const AuthGoogleState.unauthenticated());
    }
  }

  void _onLogoutRequested(
      AppLogoutRequested event, Emitter<AuthGoogleState> emit) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
