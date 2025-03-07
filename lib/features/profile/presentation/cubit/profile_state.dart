part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileGetUserDataLoading extends ProfileState {}

final class ProfileGetUserDataSuccess extends ProfileState {
  final ProfileModel profileModel;

  ProfileGetUserDataSuccess(this.profileModel);
}

final class ProfileGetUserDataError extends ProfileState {
  final String error;

  ProfileGetUserDataError({required this.error});
}

final class LogoutLoading extends ProfileState {}

final class LogoutSuccess extends ProfileState {
  LogoutSuccess();
}

final class LogoutError extends ProfileState {
  final String error;

  LogoutError({required this.error});
}
