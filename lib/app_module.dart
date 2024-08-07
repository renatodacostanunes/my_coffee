import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/controllers/session_controller.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/modules/auth/auth_module.dart';
import 'package:my_coffee/modules/auth/subModules/recoverPassword/recover_password_module.dart';
import 'package:my_coffee/modules/home/home_module.dart';
import 'package:my_coffee/modules/onboarding/onboarding_module.dart';
import 'package:my_coffee/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => SharedPrefs());
    i.addSingleton(() => SecureStorage());
    i.addSingleton(() => FirebaseAuth.instance);
    i.addSingleton(() => SessionController());
  }

  @override
  void routes(r) {
    r.module(AppRoutes.base, module: SplashModule());
    r.module(AppRoutes.onboarding, module: OnboardingModule());
    r.module(AppRoutes.auth, module: AuthModule());
    r.module(AppRoutes.home, module: HomeModule());
    r.module(AppRoutes.recoverPassword, module: RecoverPasswordModule());
  }
}
