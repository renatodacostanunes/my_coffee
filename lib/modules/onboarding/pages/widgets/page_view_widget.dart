import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/widgets/button_widget.dart';
import 'package:my_coffee/core/styles/colors.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.assetImage,
    required this.title,
    required this.subTitle,
    required this.opacity,
    this.showButtons = false,
  });

  final String assetImage;
  final String title;
  final String subTitle;
  final double opacity;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(assetImage),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(opacity),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.20),
                  Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                      height: 1.0,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.1,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    textAlign: TextAlign.center,
                    subTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: width * 0.04,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          showButtons
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWidget(
                      onPressed: () {},
                      titleButton: "Register",
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                    ),
                    SizedBox(height: height * 0.02),
                    ButtonWidget(
                      onPressed: () {},
                      titleButton: "Sign in",
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                      titleColor: AppColors.primary,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
