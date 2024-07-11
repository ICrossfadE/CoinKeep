part of 'auth_google_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthGoogleState extends Equatable {
  //AuthState._ є приватним конструктором.
  const AuthGoogleState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  // статус невідомий
  const AuthGoogleState.unknown() : this._();

  // Статус авторизованого користувача
  const AuthGoogleState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  // Статут не авторизований
  const AuthGoogleState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
