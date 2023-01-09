import 'package:flutter/material.dart';
import 'package:quitanda_com_getx/src/pages/orders/components/order_tile.dart';
import '../../config/app_data.dart' as app_data;

class OrderTab extends StatelessWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedidos',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return OrderTile(order: app_data.orders[index]);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: app_data.orders.length,
      ),
    );
  }
}
