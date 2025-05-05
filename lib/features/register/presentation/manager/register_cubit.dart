import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_regex.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/adjust_camera_page.dart';
import 'package:graduationproject/shared/auth_services.dart';
import 'package:graduationproject/shared/models/user_model.dart';
import 'package:graduationproject/shared/storage_helper.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool passwordConfirmationVisible = false;
  bool isChecked = false;

  final auth = AuthService();

  RegisterCubit() : super(RegisterInitial());

  void togglePassword() {
    emit(RegisterInitial());
    passwordVisible = !passwordVisible;
    emit(RegisterShowPasswordSuccess());
  }

  void toggleCheckTerms() {
    emit(RegisterInitial());
    isChecked = !isChecked;
    emit(RegisterCheckTermsSuccess());
  }

  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> signup() async {
    if (!validateRegisterData()) {
      return;
    }

    emit(RegisterLoading());

    final user = await auth.createUserWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (user != null) {
      user.updateDisplayName(userNameController.text);

      UserModel userModel = UserModel().toModel(user);

      StorageHelper.storeToken(user.refreshToken ?? "");
      StorageHelper.storeUserData(userModel);

      emit(RegisterSuccess());
    }else {
      emit(RegisterError(error: AppStrings.somethingWentWrong));
    }
  }

  bool validateRegisterData() {
    emit(RegisterInitial());

    if (userNameController.text.isEmpty) {
      emit(RegisterError(error: AppStrings.validateUsername));
      return false;
    }

    if (emailController.text.isEmpty) {
      emit(RegisterError(error: AppStrings.validateEmptyEmail));
      return false;
    }

    if (AppRegex.isEmailValid(emailController.text) == false) {
      emit(RegisterError(error: AppStrings.validateEmail));
      return false;
    }

    if (passwordController.text.isEmpty) {
      emit(RegisterError(error: AppStrings.validateEmptyPassword));
      return false;
    }

    if (AppRegex.hasMinLength(passwordController.text) == false) {
      emit(RegisterError(error: AppStrings.validatePassword));
      return false;
    }

    if (isChecked == false) {
      emit(RegisterError(error: AppStrings.validateTerms));
      return false;
    }

    return true;
  }
}
