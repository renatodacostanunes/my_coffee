import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/modules/auth/subModules/signIn/controllers/sign_in_controller.dart';
import 'package:my_coffee/modules/auth/subModules/signIn/pages/sign_in_page.dart';

class SignInModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => SignInController());
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.base, child: (context) => const SignInPage());
  }
}
