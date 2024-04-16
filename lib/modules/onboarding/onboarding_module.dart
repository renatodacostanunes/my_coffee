import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/modules/onboarding/controller/onboarding_controller.dart';
import 'package:my_coffee/modules/onboarding/pages/onboarding_page.dart';

class OnboardingModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => OnboardingController());
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.base, child: (context) => const OnboardingPage());
  }
}
