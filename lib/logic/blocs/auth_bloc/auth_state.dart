part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  //AuthState._ є приватним конструктором.
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  // статус невідомий
  const AuthState.unknown() : this._();

  // Статут не авторизований
  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  // Статус авторизованого користувача
  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  @override
  List<Object?> get props => [status, user];
}
