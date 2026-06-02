import 'package:json_annotation/json_annotation.dart';

part 'payment_item_dto.g.dart';

@JsonSerializable()
class PaymentItemDto {
  final String name;
  final int amount;
  final String description;
  final int quantity;
  final String? image;

  PaymentItemDto({
    required this.name,
    required this.amount,
    required this.description,
    required this.quantity,
    this.image,
  });

  factory PaymentItemDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentItemDtoToJson(this);
}
