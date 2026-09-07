part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final UserEntity user;
  RegisterSuccess(this.user);
}

final class RegisterError extends RegisterState {
  final String errMessage;

  RegisterError(this.errMessage);
}

final class CreateAccountLoading extends RegisterState {}

final class CreateAccountSuccess extends RegisterState {}

final class CreateAccountError extends RegisterState {
  final String errMessage;

  CreateAccountError(this.errMessage);
}
