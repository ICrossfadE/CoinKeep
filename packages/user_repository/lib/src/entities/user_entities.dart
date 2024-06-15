import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;

  const MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
  });

  // Перетворюємо в JSON для відправки у Firestore
  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
    };
  }

  // Перетворюємо в обєкт з Firestore
  static MyUserEntity fromDocument(Map<String, dynamic> document) {
    return MyUserEntity(
      userId: document['userId'],
      email: document['email'],
      name: document['name'],
    );
  }

  @override
  List<Object?> get props => [userId, email, name];
}
