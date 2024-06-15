part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Подія яка визначає користувача
class AuthenticationUserChanged extends AuthEvent {
  final User? user;

  const AuthenticationUserChanged(this.user);
}
