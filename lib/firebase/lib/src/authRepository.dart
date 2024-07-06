import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

// Репозиторій функціоналу по аутентифікації користувача
abstract class AuthReository {
  Stream<User?> get user; // Потік змін стану користувача
  Stream<bool> get isAuthenticated;

  Future<UserCredential> signInWithGoogle();
  Future<void> logOut(); // Вихід користувача
  Future<void> setUserData(MyUser myUser); // Збереження даних користувача
}
