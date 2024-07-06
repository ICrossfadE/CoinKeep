import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

// Model
class MyUser extends Equatable {
  final String userId;
  final String? email;
  final String? name;
  final String? photoUrl;

  // Constructor
  const MyUser({
    required this.userId,
    this.email,
    this.name,
    this.photoUrl,
  });

  // Статичний екземпляр порожнього користувача
  static MyUser empty = const MyUser(
    userId: '',
    email: '',
    name: '',
    photoUrl: '',
  );

  // Метод копіювання для оновлення
  MyUser copyWith(
      {String? userId, String? email, String? name, String? photoUrl}) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      photoUrl: photoUrl,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        email: entity.email,
        name: entity.name,
        photoUrl: entity.userId);
  }

  @override
  List<Object?> get props => [userId, email, name, photoUrl];
}
