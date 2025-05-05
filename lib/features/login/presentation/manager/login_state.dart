part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginTogglePassword extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  String error;

  LoginError({required this.error});
}
