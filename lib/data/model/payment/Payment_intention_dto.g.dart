// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Payment_intention_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentionDto _$PaymentIntentionDtoFromJson(Map<String, dynamic> json) =>
    PaymentIntentionDto(
      paymentKeys: (json['payment_keys'] as List<dynamic>)
          .map((e) => PaymentKeyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      intentionOrderId: (json['intention_order_id'] as num).toInt(),
      id: json['id'] as String,
      intentionDetail: PaymentIntentionDetailDto.fromJson(
        json['intention_detail'] as Map<String, dynamic>,
      ),
      clientSecret: json['client_secret'] as String,
      paymentMethods: (json['payment_methods'] as List<dynamic>)
          .map((e) => PaymentMethodDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialReference: json['special_reference'] as String,
      confirmed: json['confirmed'] as bool,
      status: json['status'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$PaymentIntentionDtoToJson(
  PaymentIntentionDto instance,
) => <String, dynamic>{
  'payment_keys': instance.paymentKeys,
  'intention_order_id': instance.intentionOrderId,
  'id': instance.id,
  'intention_detail': instance.intentionDetail,
  'client_secret': instance.clientSecret,
  'payment_methods': instance.paymentMethods,
  'special_reference': instance.specialReference,
  'confirmed': instance.confirmed,
  'status': instance.status,
  'created': instance.created,
};
