part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

sealed class AuthActionableState extends AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthActionableState {
  final String message;

  AuthSuccess({required this.message});
}

final class AuthError extends AuthActionableState {
  final String message;

  AuthError({required this.message});
}

final class NavigateToHome extends AuthActionableState {}

final class NavigateToLogin extends AuthActionableState {}
