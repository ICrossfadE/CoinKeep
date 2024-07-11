part of 'login_cubit.dart';

enum LoginStatus { initial, inProgress, success, failure }

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final LoginStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, isValid, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
