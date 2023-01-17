// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/models/cart_item_model.dart';

import 'package:quitanda_com_getx/src/models/order_model.dart';
import 'package:quitanda_com_getx/src/pages/common/payment_dialog.dart';
import 'package:quitanda_com_getx/src/pages/orders/components/order_status_widget.dart';
import 'package:quitanda_com_getx/src/pages/orders/controllers/order_controller.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: GetBuilder<OrderController>(
            global: false,
            init: OrderController(order: order),
            builder: ((controller) {
              return ExpansionTile(
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                onExpansionChanged: (value) {
                  if (value && order.items!.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      UtilServices.dateTimeFormatter(
                        order.createdDateTime!,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children: order.items!.map((orderItem) {
                                      return _OrderItemWidget(
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                width: 10,
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),
                              Expanded(
                                flex: 2,
                                child: OrderStatusWidget(
                                  status: order.status!,
                                  isOverdue: order.isOverDue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Total: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    UtilServices.priceToCurrency(order.total!),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) {
                                      return PaymentDialog(
                                        order: order,
                                      );
                                    }),
                                icon: Image.asset('assets/pix.png'),
                                label: const Text('Ver QR Code PIX'),
                              ),
                            ),
                          ),
                        )
                      ],
              );
            }),
          )),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(
            UtilServices.priceToCurrency(orderItem.totalPrice()),
          ),
        ],
      ),
    );
  }
}
