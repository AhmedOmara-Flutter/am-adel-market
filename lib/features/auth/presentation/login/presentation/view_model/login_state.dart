part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserEntity user;
  LoginSuccess(this.user);
}

final class LoginError extends LoginState {
  final String errMessage;

  LoginError(this.errMessage);
}

final class SignInWithGoogleLoading extends LoginState {}

final class SignInWithGoogleSuccess extends LoginState {}

final class SignInWithGoogleError extends LoginState {
  final String errMessage;

  SignInWithGoogleError(this.errMessage);
}

final class SignInWithFacebookLoading extends LoginState {}

final class SignInWithFacebookSuccess extends LoginState {}

final class SignInWithFacebookError extends LoginState {
  final String errMessage;

  SignInWithFacebookError(this.errMessage);
}
