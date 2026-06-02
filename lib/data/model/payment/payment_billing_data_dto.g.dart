// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_billing_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentBillingDataDto _$PaymentBillingDataDtoFromJson(
  Map<String, dynamic> json,
) => PaymentBillingDataDto(
  apartment: json['apartment'] as String,
  floor: json['floor'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  street: json['street'] as String,
  building: json['building'] as String,
  phoneNumber: json['phone_number'] as String,
  city: json['city'] as String,
  country: json['country'] as String,
  state: json['state'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$PaymentBillingDataDtoToJson(
  PaymentBillingDataDto instance,
) => <String, dynamic>{
  'apartment': instance.apartment,
  'floor': instance.floor,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'street': instance.street,
  'building': instance.building,
  'phone_number': instance.phoneNumber,
  'city': instance.city,
  'country': instance.country,
  'state': instance.state,
  'email': instance.email,
};
