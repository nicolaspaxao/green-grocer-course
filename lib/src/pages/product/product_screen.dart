// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/config/colors.dart';

import 'package:quitanda_com_getx/src/models/item_model.dart';
import 'package:quitanda_com_getx/src/pages/common/quantity_widget.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../base/controller/navigation_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ItemModel item;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int cartItemQuantity = 1;
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.network(
                    widget.item.imgUrl,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                          ),
                          QuantityWidget(
                            value: cartItemQuantity,
                            suffixText: widget.item.unit,
                            result: (int quantity) {
                              setState(() {
                                cartItemQuantity = quantity;
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        UtilServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: customSwatchColor,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            Get.back();
                            navigationController
                                .navigatePageView(NavigationTabs.cart);
                          },
                          label: const Text(
                            'Adicionar ao carrinho',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(Icons.shopping_cart_outlined),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
