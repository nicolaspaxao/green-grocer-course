// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:quitanda_com_getx/src/models/order_model.dart';
import 'package:quitanda_com_getx/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_com_getx/src/pages/orders/repository/orders_repository.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';
import '../result/orders_result.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController({
    required this.order,
  });

  final _ordersRepository = OrdersRepository();
  final _authController = Get.find<AuthController>();
  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    OrdersResult<List<CartItemModel>> result =
        await _ordersRepository.getOrdersItems(
      orderId: order.id!,
      token: _authController.user.token!,
    );
    setLoading(false);
    result.when(
      sucess: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        UtilServices.showToast(title: message, isError: true);
      },
    );
  }
}
