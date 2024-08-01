import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/modules/home/pages/widgets/announcement_widget.dart';
import 'package:my_coffee/modules/home/pages/widgets/tab_bar_widget.dart';
import 'package:my_coffee/modules/home/pages/widgets/user_perfil_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Modular.to.canPop(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.only(
            left: width * .05,
            top: height * .1,
            right: width * .05,
          ),
          child: Column(
            children: [
              UserPerfilWidget(),
              SizedBox(height: height * .03),
              const AnnouncementWidget(),
              SizedBox(height: height * .01),
              const TabBarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
