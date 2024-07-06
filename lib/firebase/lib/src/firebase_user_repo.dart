import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user_repository.dart';

// Реалізація функціоналу з UserRepository
class FirebaseUserRepo implements AuthReository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  // constructor
  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
    //Передаємо інший екземпляр або використовує стандартний якщо не переданий.
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Запустити потік автентифікації

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print('Google user: ${googleUser?.email}');

    if (googleUser == null) {
      throw Exception('Google Sign In was canceled');
    }

    // Отримайте дані автентифікації із запиту
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print('Got Google Auth');

    // Створіть нові облікові дані
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print('Created credential');

    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    User? user = userCredential.user;
    if (user != null) {
      // Ім'я
      String? name = user.displayName;

      // Email
      String? email = user.email;

      // URL фото профілю
      String? photoUrl = user.photoURL;

      // Тут ви можете зберегти ці дані або використати їх за потребою
      // Наприклад, зберегти в Firestore:
      // await setUserData(MyUser(
      //   userId: user.uid,
      //   name: name ?? '',
      //   email: email ?? '',
      //   photoUrl: photoUrl ?? '',
      // ));

      log('User signed in: $name, $email, $photoUrl');
    }

    // Після входу поверніть UserCredential
    return userCredential;
  }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      log('authStateChanges: $firebaseUser');
      return firebaseUser;
    });
  }

  @override
  Stream<bool> get isAuthenticated {
    return user.map((firebaseUser) {
      return firebaseUser != null;
    });
  }

  @override
  // Зберігаємо користувача у базі Firestore
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
