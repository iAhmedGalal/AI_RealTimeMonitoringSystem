import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/adjust_camera_page.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';
import 'package:graduationproject/shared/widgets/input_field_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool passwordConfirmationVisible = false;
  bool isChecked = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.registerNewAccount,
                    style: textStyleColorBoldSize(AppColors.black, 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    AppAssets.accent,
                    width: 99,
                    height: 4,
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Form(
                child: Column(
                  children: [
                    InputField(
                      hintText: AppStrings.username,
                      controller: userNameController,
                      suffixIcon: SizedBox(),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    InputField(
                      hintText: AppStrings.email,
                      controller: emailController,
                      suffixIcon: SizedBox(),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    InputField(
                      hintText: AppStrings.password,
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      suffixIcon: IconButton(
                        color: AppColors.grayTextColor,
                        splashRadius: 1,
                        icon: Icon(passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                        onPressed: togglePassword,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isChecked ? AppColors.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                        border: isChecked
                          ? null
                          : Border.all(color: AppColors.grayTextColor, width: 1.5),
                      ),
                      width: 20,
                      height: 20,
                      child: isChecked
                          ? Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.white,
                      ) : null,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.agreeToOur,
                        style: textStyleColorNormalSize(AppColors.grayTextColor, 16),
                      ),
                      Text(
                        AppStrings.termsAndConditions,
                        style: textStyleColorNormalSize(AppColors.primaryColor, 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              CustomButton(
                text: AppStrings.register,
                textAlign: TextAlign.center,
                textColor: AppColors.white,
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdjustCameraPage()),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccount,
                    style: textStyleColorNormalSize(AppColors.grayTextColor, 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Text(
                      AppStrings.login,
                      style: textStyleColorNormalSize(AppColors.primaryColor, 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}