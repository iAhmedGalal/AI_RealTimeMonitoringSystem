import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  TextAlign textAlign;
  Color backgroundColor;
  Color textColor;
  Color? borderColor;
  double borderRadius = 36;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textAlign = TextAlign.start,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.grayTextColor,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Text(
            text,
            textAlign: textAlign,
            style: textStyleColorBoldSize(textColor, 18),
          ),
        ),
      ),
    );
  }
}