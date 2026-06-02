import 'package:json_annotation/json_annotation.dart';

part 'payment_billing_data_dto.g.dart';

@JsonSerializable()
class PaymentBillingDataDto {
  final String apartment;
  final String floor;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String street;
  final String building;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  final String city;
  final String country;
  final String state;
  final String email;

  PaymentBillingDataDto({
    required this.apartment,
    required this.floor,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.building,
    required this.phoneNumber,
    required this.city,
    required this.country,
    required this.state,
    required this.email,
  });

  factory PaymentBillingDataDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentBillingDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentBillingDataDtoToJson(this);
}