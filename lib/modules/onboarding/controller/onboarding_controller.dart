import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'onboarding_controller.g.dart';

class OnboardingController = OnboardingControllerBase with _$OnboardingController;

abstract class OnboardingControllerBase with Store {
  PageController pageController = PageController();

  @observable
  int currentPage = 0;

  @action
  void pageControllerListener() => pageController.addListener(
        () => currentPage = pageController.page!.round(),
      );

  @action
  void dispose() => pageController.dispose();
}
