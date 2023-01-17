import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../../../models/order_model.dart';
import '../repository/orders_repository.dart';
import '../result/orders_result.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final _ordersRepository = OrdersRepository();
  final _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result =
        await _ordersRepository.getAllOrders(
      userId: _authController.user.id!,
      token: _authController.user.token!,
    );

    result.when(
      sucess: (orders) {
        allOrders = orders
          ..sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
        update();
      },
      error: (message) {
        UtilServices.showToast(
          title: message,
          isError: true,
        );
      },
    );
  }
}
