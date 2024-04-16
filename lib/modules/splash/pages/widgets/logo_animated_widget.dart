import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';

class LogoAnimatedWidget extends StatefulWidget {
  const LogoAnimatedWidget({super.key});

  @override
  LogoAnimatedWidgetState createState() => LogoAnimatedWidgetState();
}

class LogoAnimatedWidgetState extends State<LogoAnimatedWidget> with SingleTickerProviderStateMixin {
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
    return ScaleTransition(
      scale: _animation,
      child: Image.asset(
        "assets/images/coffee_script_logo.png",
        height: height * 0.25,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
