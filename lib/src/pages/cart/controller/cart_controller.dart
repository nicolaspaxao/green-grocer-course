import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/models/cart_item_model.dart';
import 'package:quitanda_com_getx/src/models/item_model.dart';
import 'package:quitanda_com_getx/src/models/order_model.dart';
import 'package:quitanda_com_getx/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_com_getx/src/pages/cart/repositories/cart_repository.dart';
import 'package:quitanda_com_getx/src/pages/cart/result/cart_result.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../../common/payment_dialog.dart';

class CartController extends GetxController {
  final _cartRepository = CartRepository();
  final _authController = Get.find<AuthController>();

  List<CartItemModel> cartItems = [];

  RxBool isCheckoutLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await _cartRepository.changeItemQuantity(
      token: _authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      UtilServices.showToast(
        title: 'Ocorreu um erro ao alterar a quantidade do produto',
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await _cartRepository.getCartItems(
      token: _authController.user.token!,
      userId: _authController.user.id!,
    );

    result.when(
      sucess: (data) {
        cartItems = data;
        update();
      },
      error: (error) {
        UtilServices.showToast(
          title: error,
          isError: true,
        );
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere(
      (itemInList) => itemInList.item.id == item.id,
    );
  }

  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      final CartResult<String> result = await _cartRepository.addItemToCart(
        productId: item.id,
        quantity: quantity,
        token: _authController.user.token!,
        userId: _authController.user.id!,
      );
      result.when(
        sucess: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (error) {
          UtilServices.showToast(title: error, isError: true);
        },
      );
    }
    update();
  }

  Future checkoutCart() async {
    isCheckoutLoading.value = true;
    CartResult<OrderModel> result = await _cartRepository.checkoutCart(
      token: _authController.user.token!,
      total: cartTotalPrice(),
    );
    isCheckoutLoading.value = false;

    result.when(
      sucess: (order) {
        cartItems.clear();
        update();
        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(
              order: order,
            );
          },
        );
      },
      error: (message) {
        UtilServices.showToast(title: message);
      },
    );
  }
}
