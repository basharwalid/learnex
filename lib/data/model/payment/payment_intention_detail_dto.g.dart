// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intention_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentionDetailDto _$PaymentIntentionDetailDtoFromJson(
  Map<String, dynamic> json,
) => PaymentIntentionDetailDto(
  amount: (json['amount'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => PaymentItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  currency: json['currency'] as String,
  billingData: PaymentBillingDataDto.fromJson(
    json['billing_data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PaymentIntentionDetailDtoToJson(
  PaymentIntentionDetailDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'items': instance.items,
  'currency': instance.currency,
  'billing_data': instance.billingData,
};
