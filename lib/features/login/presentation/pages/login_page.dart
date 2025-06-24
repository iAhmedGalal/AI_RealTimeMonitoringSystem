import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/about/presentation/pages/about_page.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/adjust_camera_page.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/camera_stream_page.dart';
import 'package:graduationproject/features/home/presentation/pages/home_screen.dart';
import 'package:graduationproject/features/login/presentation/manager/login_cubit.dart';
import 'package:graduationproject/features/register/presentation/pages/register_page.dart';
import 'package:graduationproject/shared/auth_services.dart';
import 'package:graduationproject/shared/models/user_model.dart';
import 'package:graduationproject/shared/storage_helper.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';
import 'package:graduationproject/shared/widgets/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }

            if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.loginToYourAccount,
                          style: textStyleColorBoldSize(AppColors.black, 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          AppAssets.accent,
                          width: 99,
                          height: 4,
                          color: AppColors.greenBackground,
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
                            hintText: AppStrings.email,
                            controller: context.read<LoginCubit>().emailController,
                            suffixIcon: SizedBox(),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InputField(
                            hintText: AppStrings.password,
                            controller: context.read<LoginCubit>().passwordController,
                            obscureText: !context.read<LoginCubit>().passwordVisible,
                            suffixIcon: IconButton(
                              color: AppColors.grayTextColor,
                              splashRadius: 1,
                              icon: Icon(context.read<LoginCubit>().passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                              onPressed: context.read<LoginCubit>().togglePassword,
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

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenBackground,
                            ),
                          );
                        }

                        return CustomButton(
                          text: AppStrings.login,
                          textAlign: TextAlign.center,
                          textColor: AppColors.white,
                          backgroundColor: AppColors.greenBackground,
                          onPressed: () {
                            context.read<LoginCubit>().login();
                          },
                        );
                      }
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.haveAccount,
                          style: textStyleColorNormalSize(AppColors.grayTextColor, 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text(
                            AppStrings.register,
                            style: textStyleColorNormalSize(AppColors.greenBackground, 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        )
      ),
    );
  }
}