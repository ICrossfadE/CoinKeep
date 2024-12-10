import 'dart:developer';
import 'package:CoinKeep/firebase/lib/src/entities/userData_entities.dart';
// import 'package:CoinKeep/firebase/lib/src/models/transaction.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user_repository.dart';

class FirebaseUserRepo implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Виходимо з поточного Google акаунту перед новим входом
    await _googleSignIn.signOut();

    // Запускаємо потік автентифікації
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    log('Google user: ${googleUser?.email}');

    if (googleUser == null) {
      throw Exception('Google Sign In was canceled');
    }

    // Отримуємо дані автентифікації із запиту
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    log('Got Google Auth');

    // Створюємо нові облікові дані
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    log('Created credential');

    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    User? user = userCredential.user;
    if (user != null) {
      String? name = user.displayName;
      String? email = user.email;
      String? photoUrl = user.photoURL;

      log('User signed in: $name, $email, $photoUrl');

      // Перевірка наявності користувача у Firestore
      DocumentSnapshot userDoc = await usersCollection.doc(user.uid).get();

      if (!userDoc.exists) {
        // Якщо користувача ще немає, створюємо нові дані
        UserDataEntity userData = UserDataEntity(
          userId: user.uid,
          wallets: const [],
          transactions: const [],
        );

        await setUserData(userData);
      } else {
        // Якщо користувач існує, ви можете отримати та використовувати старі дані
        log('User data already exists for user: ${user.uid}');
      }
    }

    return userCredential;
  }

  Future<void> setUserData(UserDataEntity userData) async {
    try {
      // Створіть документ користувача в основній колекції
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.userId)
          .set({
        // Можна додати будь-які додаткові дані користувача тут
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      log('User data set successfully for user: ${userData.userId}');
    } catch (e) {
      log('Failed to set user data: $e');
      rethrow;
    }
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
    return user.map((firebaseUser) => firebaseUser != null);
  }

  @override
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
