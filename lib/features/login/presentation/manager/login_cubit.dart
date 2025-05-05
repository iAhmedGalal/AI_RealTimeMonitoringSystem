import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduationproject/core/utils/app_regex.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/shared/auth_services.dart';
import 'package:graduationproject/shared/models/user_model.dart';
import 'package:graduationproject/shared/storage_helper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  void togglePassword() {
    emit(LoginInitial());
    passwordVisible = !passwordVisible;
    emit(LoginTogglePassword());
  }

  Future<void> login() async {
    if (!validateRegisterData()) {
      return;
    }

    emit(LoginLoading());

    final user = await auth.loginUserWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (user != null) {
      UserModel userModel = UserModel().toModel(user);

      StorageHelper.storeToken(user.refreshToken ?? "");
      StorageHelper.storeUserData(userModel);

      emit(LoginSuccess());
    }else {
      emit(LoginError(error: AppStrings.somethingWentWrong));
    }
  }

  bool validateRegisterData() {
    emit(LoginInitial());

    if (emailController.text.isEmpty) {
      emit(LoginError(error: AppStrings.validateEmptyEmail));
      return false;
    }

    if (AppRegex.isEmailValid(emailController.text) == false) {
      emit(LoginError(error: AppStrings.validateEmail));
      return false;
    }

    if (passwordController.text.isEmpty) {
      emit(LoginError(error: AppStrings.validateEmptyPassword));
      return false;
    }

    return true;
  }
}
