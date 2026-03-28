import 'package:learnex/domain/model/class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class_dto.g.dart';

@JsonSerializable()
class ClassDto {
  final int? id;

  @JsonKey(name: 'course_id')
  final int? courseId;

  @JsonKey(name: 'class_date')
  final DateTime? classDate;

  @JsonKey(name: 'class_time')
  final String? classTime;

  final int? price;

  @JsonKey(name: 'total_seats')
  final int? totalSeats;

  @JsonKey(name: 'available_seats')
  final int? availableSeats;

  @JsonKey(name: 'meeting_link')
  final String? meetingLink;

  final String? status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  ClassDto({
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

  factory ClassDto.fromJson(Map<String, dynamic> json) =>
      _$ClassDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClassDtoToJson(this);
}

extension ClassDtoMapper on ClassDto {
  Class toDomain() => Class(
    id: id,
    courseId: courseId,
    classDate: classDate,
    classTime: classTime,
    price: price,
    totalSeats: totalSeats,
    availableSeats: availableSeats,
    meetingLink: meetingLink,
    status: status,
  );
}
