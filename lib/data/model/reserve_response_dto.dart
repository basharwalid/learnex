import 'package:json_annotation/json_annotation.dart';

part 'reserve_response_dto.g.dart';

@JsonSerializable()
class ReserveResponseDto {
  @JsonKey(name: 'order_id')
  final String orderId;

  ReserveResponseDto({required this.orderId});

  factory ReserveResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReserveResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReserveResponseDtoToJson(this);
}