part of 'auth_cubit_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}


class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final AuthModel loginModel;

  LoginSuccess({required this.loginModel});
}

class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}

class RegisterSuccess extends AuthState {
  final AuthModel registerModel;

  RegisterSuccess({required this.registerModel});
}
