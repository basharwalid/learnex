import 'package:json_annotation/json_annotation.dart';

part 'payment_method_dto.g.dart';

@JsonSerializable()
class PaymentMethodDto {
  @JsonKey(name: 'integration_id')
  final int integrationId;

  final String? alias;
  final String? name;

  @JsonKey(name: 'method_type')
  final String methodType;

  final String currency;
  final bool live;

  PaymentMethodDto({
    required this.integrationId,
    this.alias,
    this.name,
    required this.methodType,
    required this.currency,
    required this.live,
  });

  factory PaymentMethodDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDtoToJson(this);
}
