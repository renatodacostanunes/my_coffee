import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/widgets/button_widget.dart';
import 'package:my_coffee/locale/language.dart';

class ButtonAnimatedWidget extends StatefulWidget {
  const ButtonAnimatedWidget({super.key});

  @override
  ButtonAnimatedWidgetState createState() => ButtonAnimatedWidgetState();
}

class ButtonAnimatedWidgetState extends State<ButtonAnimatedWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Language().translation(context);
    return ScaleTransition(
      scale: _animation,
      child: ButtonWidget(
        onPressed: () => Modular.to.pushNamedAndRemoveUntil(
          AppRoutes.onboarding,
          (_) => false,
        ),
        titleButton: lang.getStarted,
        margin: EdgeInsets.symmetric(horizontal: width * 0.15),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
