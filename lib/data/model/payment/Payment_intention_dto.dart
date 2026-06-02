import 'package:json_annotation/json_annotation.dart';
import 'package:learnex/data/model/payment/payment_intention_detail_dto.dart';
import 'package:learnex/data/model/payment/payment_key_dto.dart';
import 'package:learnex/data/model/payment/payment_method_dto.dart';
import 'package:learnex/domain/model/payment/payment_intention.dart';

part 'Payment_intention_dto.g.dart';

@JsonSerializable()
class PaymentIntentionDto {
  @JsonKey(name: 'payment_keys')
  final List<PaymentKeyDto> paymentKeys;

  @JsonKey(name: 'intention_order_id')
  final int intentionOrderId;

  final String id;

  @JsonKey(name: 'intention_detail')
  final PaymentIntentionDetailDto intentionDetail;

  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @JsonKey(name: 'payment_methods')
  final List<PaymentMethodDto> paymentMethods;

  @JsonKey(name: 'special_reference')
  final String specialReference;

  final bool confirmed;
  final String status;
  final String created;

  PaymentIntentionDto({
    required this.paymentKeys,
    required this.intentionOrderId,
    required this.id,
    required this.intentionDetail,
    required this.clientSecret,
    required this.paymentMethods,
    required this.specialReference,
    required this.confirmed,
    required this.status,
    required this.created,
  });

  factory PaymentIntentionDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentionDtoToJson(this);
}

extension PaymentIntentionDtoMapper on PaymentIntentionDto {
  PaymentIntention toDomain() => PaymentIntention(
    clientSecret: clientSecret,
    id: id,
    status: status,
    intentionOrderId: intentionOrderId,
    paymentKeys: paymentKeys
        .map((e) => PaymentKey(
      integration: e.integration,
      key: e.key,
      gatewayType: e.gatewayType,
      orderId: e.orderId,
    ))
        .toList(),
  );
}






