import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';

import 'pages/splash_page.dart';

class SplashModule extends Module {
  @override
  void routes(r) {
    r.child(AppRoutes.base, child: (context) => const SplashPage());
  }
}
