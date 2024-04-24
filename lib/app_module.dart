import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/modules/auth/auth_module.dart';
import 'package:my_coffee/modules/onboarding/onboarding_module.dart';
import 'package:my_coffee/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => SecureStorage());
  }

  @override
  void routes(r) {
    r.module(AppRoutes.base, module: SplashModule());
    r.module(AppRoutes.onboarding, module: OnboardingModule());
    r.module(AppRoutes.auth, module: AuthModule());
  }
}
