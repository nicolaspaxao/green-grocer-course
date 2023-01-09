import 'package:quitanda_com_getx/src/models/cart_item_model.dart';

class OrderModel {
  String? copyAndPaste;
  DateTime? createdDateTime;
  DateTime? overdueDateTime;
  String? id;
  String? status;
  double? total;
  List<CartItemModel>? items;

  OrderModel({
    this.copyAndPaste,
    this.createdDateTime,
    this.overdueDateTime,
    this.id,
    this.status,
    this.total,
    this.items,
  });
}
