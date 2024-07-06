import 'package:CoinKeep/firebase/lib/src/authRepository.dart';
import 'package:CoinKeep/logic/blocs/login_google_cubit/auth_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authReository) : super(const LoginState());

  final AuthReository _authReository;

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.inProgress));
    try {
      print('Starting Google Sign In');
      await _authReository.signInWithGoogle();
      print('Google Sign In Successful');
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      print('Google Sign In Failed: ${e.message}');
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.failure,
        ),
      );
    } catch (e) {
      print('Unexpected error during Google Sign In: $e');
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
