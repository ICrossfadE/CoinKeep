part of 'auth_google_bloc.dart';

class AuthGoogleEvent extends Equatable {
  const AuthGoogleEvent();

  @override
  List<Object> get props => [];
}

final class AppLogoutRequested extends AuthGoogleEvent {
  const AppLogoutRequested();
}

final class AppUserChanged extends AuthGoogleEvent {
  const AppUserChanged(this.user);

  final User? user;
}
