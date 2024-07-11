import 'package:firebase_auth/firebase_auth.dart';

// Репозиторій функціоналу по аутентифікації користувача
abstract class AuthRepository {
  Stream<User?> get user; // Потік змін стану користувача
  Stream<bool> get isAuthenticated;

  Future<UserCredential> signInWithGoogle();
  Future<void> logOut(); // Вихід користувача
}
