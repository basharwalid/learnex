// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodDto _$PaymentMethodDtoFromJson(Map<String, dynamic> json) =>
    PaymentMethodDto(
      integrationId: (json['integration_id'] as num).toInt(),
      alias: json['alias'] as String?,
      name: json['name'] as String?,
      methodType: json['method_type'] as String,
      currency: json['currency'] as String,
      live: json['live'] as bool,
    );

Map<String, dynamic> _$PaymentMethodDtoToJson(PaymentMethodDto instance) =>
    <String, dynamic>{
      'integration_id': instance.integrationId,
      'alias': instance.alias,
      'name': instance.name,
      'method_type': instance.methodType,
      'currency': instance.currency,
      'live': instance.live,
    };
