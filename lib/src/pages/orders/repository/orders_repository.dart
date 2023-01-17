import 'package:quitanda_com_getx/src/constants/endpoints.dart';
import 'package:quitanda_com_getx/src/models/cart_item_model.dart';
import 'package:quitanda_com_getx/src/models/order_model.dart';
import 'package:quitanda_com_getx/src/pages/orders/result/orders_result.dart';
import 'package:quitanda_com_getx/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<CartItemModel>>> getOrdersItems({
    required String orderId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> items = (result['result'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e))
          .toList();
      return OrdersResult<List<CartItemModel>>.sucess(items);
    } else {
      return OrdersResult.error(
        'Não foi possível recuperar os produtos dos pedidos.',
      );
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders = (result['result'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e))
          .toList();
      return OrdersResult<List<OrderModel>>.sucess(orders);
    } else {
      return OrdersResult.error('Não foi possível recuperar os pedidos.');
    }
  }
}
