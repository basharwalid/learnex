import 'package:json_annotation/json_annotation.dart';

part 'classes_response_dto.g.dart';

@JsonSerializable()
class ClassesResponseDto{
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "course_id")
  final int? courseId;
  @JsonKey(name: "class_date")
  final String? classDate;
  @JsonKey(name: "class_time")
  final String? classTime;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "total_seats")
  final int? totalSeats;
  @JsonKey(name: "available_seats")
  final int? availableSeats;
  @JsonKey(name: "meeting_link")
  final dynamic? meetingLink;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created_at")
  final String? createdAt;

  ClassesResponseDto ({
    this.id,
    this.courseId,
    this.classDate,
    this.classTime,
    this.price,
    this.totalSeats,
    this.availableSeats,
    this.meetingLink,
    this.status,
    this.createdAt,
  });

  factory ClassesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ClassesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClassesResponseDtoToJson(this);
  }
}


