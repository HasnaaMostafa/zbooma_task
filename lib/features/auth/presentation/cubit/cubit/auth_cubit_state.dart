part of 'auth_cubit_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}


class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}

class LoginError extends AuthState {
  final String error;

  LoginError({required this.error});
}
