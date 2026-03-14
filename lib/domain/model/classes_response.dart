import 'package:json_annotation/json_annotation.dart';
import 'package:learnex/data/model/classes_response_dto.dart';

part 'classes_response.g.dart';

@JsonSerializable()
class ClassesResponse{
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

  ClassesResponse ({
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

  factory ClassesResponse.fromJson(Map<String, dynamic> json) {
    return _$ClassesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClassesResponseToJson(this);
  }

  ClassesResponseDto toData() {
    return ClassesResponseDto(
      id: id,
      courseId: courseId,
      classDate: classDate,
      classTime: classTime,
      price: price,
      totalSeats: totalSeats,
      availableSeats: availableSeats,
      meetingLink: meetingLink,
      status: status,
      createdAt: createdAt,
    );
  }
}


