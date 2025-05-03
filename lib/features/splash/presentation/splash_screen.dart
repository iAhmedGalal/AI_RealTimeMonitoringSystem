import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/login/presentation/pages/login_page.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _startDelay(context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenBackground, // اللون الأخضر بالخلفية
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.med,
                style: textStyleColorBoldSize(Colors.white70, 32).copyWith(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: AppStrings.vision,
                style: textStyleColorBoldSize(AppColors.greenText, 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}