import 'package:json_annotation/json_annotation.dart';

part 'payment_key_dto.g.dart';

@JsonSerializable()
class PaymentKeyDto {
  final int integration;
  final String key;

  @JsonKey(name: 'gateway_type')
  final String gatewayType;

  @JsonKey(name: 'iframe_id')
  final int? iframeId;

  @JsonKey(name: 'order_id')
  final int orderId;

  PaymentKeyDto({
    required this.integration,
    required this.key,
    required this.gatewayType,
    this.iframeId,
    required this.orderId,
  });

  factory PaymentKeyDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentKeyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentKeyDtoToJson(this);
}
