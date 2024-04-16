import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.onPressed,
    required this.titleButton,
    this.margin,
    this.titleColor = AppColors.background,
    this.backgroundColor = AppColors.primary,
    super.key,
  });

  final void Function()? onPressed;
  final String titleButton;
  final Color titleColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height * .08,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: AppColors.primary, width: 2),
          ),
          foregroundColor: AppColors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          titleButton,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05,
          ),
        ),
      ),
    );
  }
}
