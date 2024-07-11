import 'dart:developer';
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
    }

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
    return user.map((firebaseUser) => firebaseUser != null);
  }

  @override
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}



  // Тут можна зберегти ці дані або використати їх за потребою
      // Наприклад, зберегти в Firestore:
      // await setUserData(MyUser(
      //   userId: user.uid,
      //   name: name ?? '',
      //   photoUrl: photoUrl ?? '',
      // ));

      // @override
  // // Зберігаємо користувача у базі Firestore
  // Future<void> setUserData(MyUser myUser) async {
  //   try {
  //     await usersCollection
  //         .doc(myUser.userId)
  //         .set(myUser.toEntity().toDocument());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }