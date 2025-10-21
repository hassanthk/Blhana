part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String firstName;
  final String lastName;
  final String email;

  UserLoaded({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserLoggedOut extends UserState {}