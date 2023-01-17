import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/auth/view/sign_in_screen.dart';
import 'package:quitanda_com_getx/src/pages/auth/view/sign_up_screen.dart';
import 'package:quitanda_com_getx/src/pages/base/base_screen.dart';
import 'package:quitanda_com_getx/src/pages/base/binding/navigation_binding.dart';
import 'package:quitanda_com_getx/src/pages/cart/binding/cart_binding.dart';
import 'package:quitanda_com_getx/src/pages/home/binding/home_binding.dart';
import 'package:quitanda_com_getx/src/pages/orders/binding/orders_binding.dart';
import 'package:quitanda_com_getx/src/pages/product/product_screen.dart';

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
      name: PagesRoutes.productRoute,
      page: () => ProductScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/splash';
  static const String signinRoute = '/signin';
  static const String productRoute = '/product';
  static const String signupRoute = '/signup';
  static const String baseRoute = '/';
}
