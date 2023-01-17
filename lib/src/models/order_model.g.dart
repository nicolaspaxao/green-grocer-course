// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      copyAndPaste: json['copiaecola'] as String?,
      overdueDateTime:
          json['due'] == null ? null : DateTime.parse(json['due'] as String),
      createdDateTime: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      qrCodeImage: json['qrCodeImage'] as String?,
      id: json['id'] as String?,
      status: json['status'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'copiaecola': instance.copyAndPaste,
      'due': instance.overdueDateTime?.toIso8601String(),
      'createdAt': instance.createdDateTime?.toIso8601String(),
      'qrCodeImage': instance.qrCodeImage,
      'id': instance.id,
      'status': instance.status,
      'total': instance.total,
      'items': instance.items,
    };
