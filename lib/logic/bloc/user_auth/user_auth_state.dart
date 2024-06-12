part of 'user_auth_bloc.dart';

sealed class UserAuthState extends Equatable {
  const UserAuthState();
  
  @override
  List<Object> get props => [];
}

final class UserAuthInitial extends UserAuthState {}
