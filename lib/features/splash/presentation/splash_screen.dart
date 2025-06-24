import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/adjust_camera_page.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/camera_stream_page.dart';
import 'package:graduationproject/features/home/presentation/pages/home_screen.dart';
import 'package:graduationproject/features/login/presentation/pages/login_page.dart';
import 'package:graduationproject/shared/storage_helper.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _startDelay(context) {
    Future.delayed(Duration(seconds: 3), () {
      var token = StorageHelper.getStoredToken();

      if (token == null || token == "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
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
      backgroundColor: AppColors.greenBackground,
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