import 'package:get/get.dart';

import 'src/pages/auth/controller/auth_controller.dart';

class DependencyInjection {
  static init() {
    Get.put<AuthController>(AuthController());
  }
}
