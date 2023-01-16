import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/cart/controller/cart_controller.dart';

class CartBinding with Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
