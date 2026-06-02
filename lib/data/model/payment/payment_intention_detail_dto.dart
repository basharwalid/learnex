import 'package:json_annotation/json_annotation.dart';
import 'package:learnex/data/model/payment/payment_billing_data_dto.dart';
import 'package:learnex/data/model/payment/payment_item_dto.dart';

part 'payment_intention_detail_dto.g.dart';

@JsonSerializable()
class PaymentIntentionDetailDto {
  final int amount;
  final List<PaymentItemDto> items;
  final String currency;

  @JsonKey(name: 'billing_data')
  final PaymentBillingDataDto billingData;

  PaymentIntentionDetailDto({
    required this.amount,
    required this.items,
    required this.currency,
    required this.billingData,
  });

  factory PaymentIntentionDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentionDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentionDetailDtoToJson(this);
}