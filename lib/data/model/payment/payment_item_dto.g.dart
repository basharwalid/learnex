// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentItemDto _$PaymentItemDtoFromJson(Map<String, dynamic> json) =>
    PaymentItemDto(
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PaymentItemDtoToJson(PaymentItemDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'description': instance.description,
      'quantity': instance.quantity,
      'image': instance.image,
    };
