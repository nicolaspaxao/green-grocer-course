// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quitanda_com_getx/src/config/colors.dart';
import 'package:quitanda_com_getx/src/models/item_model.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../../../../app_pages.dart';
import '../../cart/controller/cart_controller.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();

  IconData tileIcon = Icons.add_shopping_cart_outlined;
  Color tileColor = customSwatchColor;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    setState(() => tileColor = customConstrastColor);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
    setState(() => tileColor = customSwatchColor);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.network(
                          widget.item.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        UtilServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 20,
                          color: customSwatchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' /${widget.item.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(15),
            ),
            child: Material(
              child: GetBuilder<CartController>(
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      switchIcon();
                      controller.addItemToCart(item: widget.item);
                      widget.cartAnimationMethod(imageGk);
                    },
                    child: Ink(
                      height: 40,
                      width: 35,
                      decoration: BoxDecoration(
                        color: tileColor,
                      ),
                      child: Icon(
                        tileIcon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
