import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/locale/language.dart';
import 'package:my_coffee/modules/onboarding/controller/onboarding_controller.dart';
import 'package:my_coffee/modules/onboarding/pages/widgets/page_view_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final controller = Modular.get<OnboardingController>();

  @override
  void initState() {
    super.initState();
    controller.pageControllerListener();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Language().translation(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Observer(
          builder: (context) {
            return Stack(
              children: [
                PageView(
                  controller: controller.pageController,
                  children: [
                    PageViewWidget(
                      assetImage: "assets/images/onboarding_zero.png",
                      title: lang.embraceCoffe,
                      subTitle: lang.lorem,
                      opacity: .50,
                    ),
                    PageViewWidget(
                      assetImage: "assets/images/onboarding_one.png",
                      title: lang.unforgettableExperience,
                      subTitle: lang.lorem,
                      opacity: .64,
                    ),
                    PageViewWidget(
                      assetImage: "assets/images/onboarding_two.png",
                      title: lang.unlockGrain,
                      subTitle: lang.lorem,
                      opacity: .50,
                      showButtons: true,
                    ),
                  ],
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                      child: SizedBox(
                        height: height * .04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...List.generate(
                              3,
                              (index) => _buildIndicator(index),
                            ),
                            const Spacer(),
                            Visibility(
                              visible: controller.currentPage != 2,
                              child: InkWell(
                                onTap: () => controller.pageController.nextPage(
                                  duration: Durations.long1,
                                  curve: Curves.ease,
                                ),
                                child: Text(
                                  lang.skip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 2.0,
      width: controller.currentPage == index ? 24 : 12,
      decoration: BoxDecoration(
        color: controller.currentPage == index ? AppColors.primary : AppColors.grey,
        borderRadius: BorderRadius.circular(1.0),
      ),
    );
  }
}
