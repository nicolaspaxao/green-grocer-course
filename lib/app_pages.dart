import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/auth/view/sign_in_screen.dart';
import 'package:quitanda_com_getx/src/pages/auth/view/sign_up_screen.dart';
import 'package:quitanda_com_getx/src/pages/base/base_screen.dart';

import 'src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signinRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signupRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/splash';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String baseRoute = '/';
}
