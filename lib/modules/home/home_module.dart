import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/modules/home/controller/home_controller.dart';
import 'package:my_coffee/modules/home/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => HomeController());
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.base, child: (context) => HomePage());
  }
}
