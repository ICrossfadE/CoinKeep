import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>(_signIn);
    on<SignOutRequired>(_logOut);
  }

  void _signIn(SignInRequired event, Emitter<SignInState> emit) async {
    try {
      await _userRepository.signIn(event.email, event.password);
      emit(SignInSuccess());
    } on FirebaseAuthException catch (error) {
      emit(SignInFailure(message: error.code));
    } catch (error) {
      emit(const SignInFailure());
    }
  }

  void _logOut(SignOutRequired event, Emitter<SignInState> emit) async {
    await _userRepository.logOut();
  }
}
