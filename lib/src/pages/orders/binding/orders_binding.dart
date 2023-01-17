import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/orders/controllers/all_orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AllOrdersController>(AllOrdersController());
  }
}
