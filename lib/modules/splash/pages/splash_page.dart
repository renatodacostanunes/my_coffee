import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/modules/splash/pages/widgets/button_animated_widget.dart';
import 'package:my_coffee/modules/splash/pages/widgets/logo_animated_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_splash.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.brown.withOpacity(.79),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.21),
                  const LogoAnimatedWidget(),
                  const Spacer(),
                  const ButtonAnimatedWidget(),
                  SizedBox(height: height * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
