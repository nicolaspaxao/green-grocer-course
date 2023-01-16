// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quitanda_com_getx/src/config/colors.dart';
import 'package:quitanda_com_getx/src/models/cart_item_model.dart';
import 'package:quitanda_com_getx/src/pages/common/quantity_widget.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../controller/cart_controller.dart';

class CartTile extends StatefulWidget {
  const CartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItemModel cartItem;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          UtilServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: GetBuilder<CartController>(
          builder: (controller) {
            return QuantityWidget(
              value: widget.cartItem.quantity,
              suffixText: widget.cartItem.item.unit,
              isRemovable: true,
              result: ((quantity) {
                controller.changeItemQuantity(
                  item: widget.cartItem,
                  quantity: quantity,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
