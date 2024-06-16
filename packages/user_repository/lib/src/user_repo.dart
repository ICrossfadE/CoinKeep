import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

// Репозиторій функціоналу по аутентифікації користувача
abstract class UserRepository {
  Stream<User?> get user; // Потік змін стану користувача
  Future<MyUser> signUp(
      MyUser myUser, String password); // Реєстрація нового користувача
  Future<void> signIn(String email, String password); // Вхід користувача
  Future<void> logOut(); // Вихід користувача
  Future<void> setUserData(MyUser myUser); // Збереження даних користувача
}
