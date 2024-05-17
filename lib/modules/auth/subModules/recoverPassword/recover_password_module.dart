import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/modules/auth/subModules/recoverPassword/controllers/recover_password_controller.dart';
import 'package:my_coffee/modules/auth/subModules/recoverPassword/pages/recover_password_page.dart';

class RecoverPasswordModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => RecoverPasswordController());
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutes.base,
      child: (context) => RecoverPasswordPage(
        controller: Modular.get<RecoverPasswordController>(),
      ),
    );
  }
}
