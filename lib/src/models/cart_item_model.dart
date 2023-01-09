import 'package:quitanda_com_getx/src/models/item_model.dart';

class CartItemModel {
  ItemModel? item;
  int? quantity;

  CartItemModel({
    this.item,
    this.quantity,
  });

  double totalPrice() => item!.price * quantity!;
}
