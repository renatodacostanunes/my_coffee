import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/widgets/language_widget.dart';
import 'package:my_coffee/locale/language.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final lang = Language().translation(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("WIDTH: $width"),
            Text("HEIGHT: $height"),
            SizedBox(height: height * .2),
            Text(lang.helloWorld),
            SizedBox(height: height * .1),
            const LanguageWidget(),
          ],
        ),
      ),
    );
  }
}
