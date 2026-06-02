// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_key_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentKeyDto _$PaymentKeyDtoFromJson(Map<String, dynamic> json) =>
    PaymentKeyDto(
      integration: (json['integration'] as num).toInt(),
      key: json['key'] as String,
      gatewayType: json['gateway_type'] as String,
      iframeId: (json['iframe_id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentKeyDtoToJson(PaymentKeyDto instance) =>
    <String, dynamic>{
      'integration': instance.integration,
      'key': instance.key,
      'gateway_type': instance.gatewayType,
      'iframe_id': instance.iframeId,
      'order_id': instance.orderId,
    };
