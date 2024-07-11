import 'dart:async';

import 'package:CoinKeep/firebase/lib/src/authRepository.dart';
import 'package:CoinKeep/logic/blocs/login_google_cubit/auth_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;
  final _logger = Logger('LoginCubit');

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.inProgress));
    try {
      _logger.info('Starting Google Sign In');
      await _authRepository.signInWithGoogle().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Login timed out');
        },
      );
      _logger.info('Google Sign In Successful');
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      _logger.info('Google Sign In Failed: ${e.message}');
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.failure,
        ),
      );
    } catch (e) {
      _logger.info('Unexpected error during Google Sign In: $e');
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
