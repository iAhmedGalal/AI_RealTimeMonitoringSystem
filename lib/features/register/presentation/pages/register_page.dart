import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/adjust_camera_page.dart';
import 'package:graduationproject/features/register/presentation/manager/register_cubit.dart';
import 'package:graduationproject/shared/auth_services.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';
import 'package:graduationproject/shared/widgets/input_field_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdjustCameraPage()),
              );
            }

            if (state is RegisterError) {
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
                            hintText: AppStrings.username,
                            controller: context.read<RegisterCubit>().userNameController,
                            suffixIcon: SizedBox(),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InputField(
                            hintText: AppStrings.email,
                            controller: context.read<RegisterCubit>().emailController,
                            suffixIcon: SizedBox(),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InputField(
                            hintText: AppStrings.password,
                            controller: context.read<RegisterCubit>().passwordController,
                            obscureText: !context.read<RegisterCubit>().passwordVisible,
                            suffixIcon: IconButton(
                              color: AppColors.grayTextColor,
                              splashRadius: 1,
                              icon: Icon(context.read<RegisterCubit>().passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                              onPressed: context.read<RegisterCubit>().togglePassword,
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
                            context.read<RegisterCubit>().toggleCheckTerms();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.read<RegisterCubit>().isChecked ? AppColors.primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(4.0),
                              border: context.read<RegisterCubit>().isChecked
                                ? null
                                : Border.all(color: AppColors.grayTextColor, width: 1.5),
                            ),
                            width: 20,
                            height: 20,
                            child: context.read<RegisterCubit>().isChecked
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
                              style: textStyleColorNormalSize(AppColors.greenBackground, 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),

                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenBackground,
                            ),
                          );
                        }

                        return CustomButton(
                          text: AppStrings.register,
                          textAlign: TextAlign.center,
                          textColor: AppColors.white,
                          backgroundColor: AppColors.greenBackground,
                          onPressed: () {
                            context.read<RegisterCubit>().signup();
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
      )
    );
  }
}