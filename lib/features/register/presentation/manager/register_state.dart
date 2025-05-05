part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterShowPasswordSuccess extends RegisterState {}
class RegisterCheckTermsSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  String error;
  RegisterError({required this.error});
}
