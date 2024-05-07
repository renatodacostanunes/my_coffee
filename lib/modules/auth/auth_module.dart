import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/modules/auth/subModules/signIn/sign_in_module.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/sign_up_module.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => SharedPrefs());
    super.binds(i);
  }

  @override
  void routes(r) {
    r.module(AppRoutes.signIn, module: SignInModule());
    r.module(AppRoutes.signUp, module: SignUpModule());
  }
}
