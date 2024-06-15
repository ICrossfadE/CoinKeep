import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

//Пепозиторій функціоналу по аунтетифікації користувача
abstract class UserRepository {
  Stream<User?> get user;
  Future<MyUser> signUp(MyUser myUser, String password);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
  Future<void> setUserData(MyUser myUser);
}
