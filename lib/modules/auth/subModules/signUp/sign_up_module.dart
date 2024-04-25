import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/controllers/sign_up_controller.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/pages/sign_up_page.dart';

class SignUpModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => SignUpController());
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.base, child: (context) => const SignUpPage());
  }
}
