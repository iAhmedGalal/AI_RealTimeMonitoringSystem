import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.aboutUs,
          style: textStyleColorBoldSize(AppColors.black, 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // About Us content
              Text(
                AppStrings.info,
                textAlign: TextAlign.center,
                style: textStyleColorNormalSize(AppColors.black, 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
