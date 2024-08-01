import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/widgets/button_widget.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/locale/language.dart';

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
    final lang = Language().translation(context);
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
                      fontSize: width * 0.08,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    textAlign: TextAlign.center,
                    subTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: width * 0.035,
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
                      onPressed: () {
                        Modular.to.pushNamedAndRemoveUntil(
                          AppRoutes.auth + AppRoutes.signUp,
                          (_) => false,
                        );
                      },
                      titleButton: lang.register,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                    ),
                    SizedBox(height: height * 0.02),
                    ButtonWidget(
                      onPressed: () {
                        Modular.to.pushNamedAndRemoveUntil(
                          AppRoutes.auth + AppRoutes.signIn,
                          (_) => false,
                        );
                      },
                      titleButton: lang.signIn,
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
