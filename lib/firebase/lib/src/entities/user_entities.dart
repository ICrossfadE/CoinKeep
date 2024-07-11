import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String? email;
  final String? name;
  final String? photoUrl;

  const MyUserEntity({
    required this.userId,
    this.email,
    this.name,
    this.photoUrl,
  });

  // Перетворюємо в JSON для відправки у Firestore
  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  // Перетворюємо в обєкт з Firestore
  static MyUserEntity fromDocument(Map<String, dynamic> document) {
    return MyUserEntity(
      userId: document['userId'],
      email: document['email'],
      name: document['name'],
      photoUrl: document['photoUrl'],
    );
  }

  @override
  List<Object?> get props => [userId, email, name, photoUrl];
}
