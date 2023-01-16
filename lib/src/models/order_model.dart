import 'package:json_annotation/json_annotation.dart';

import 'package:quitanda_com_getx/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: 'copiaecola')
  String? copyAndPaste;

  @JsonKey(name: 'due')
  DateTime? overdueDateTime;

  DateTime? createdDateTime;
  String? qrCodeImage;
  String? id;
  String? status;
  double? total;

  @JsonKey(defaultValue: [])
  List<CartItemModel>? items;

  OrderModel({
    this.copyAndPaste,
    this.overdueDateTime,
    this.createdDateTime,
    this.qrCodeImage,
    this.id,
    this.status,
    this.total,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel(copyAndPaste: $copyAndPaste, overdueDateTime: $overdueDateTime, createdDateTime: $createdDateTime, qrCodeImage: $qrCodeImage, id: $id, status: $status, total: $total, items: $items)';
  }
}
