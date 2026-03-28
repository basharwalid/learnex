import 'package:json_annotation/json_annotation.dart';
import 'package:learnex/domain/model/course.dart';

part 'course_dto.g.dart';

@JsonSerializable()
class CourseDto {
  final int id;
  final String name;
  final String description;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  CourseDto({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory CourseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDtoToJson(this);
}

extension CourseDtoMapper on CourseDto{
  Course toDomain() => Course(
    id: id,
    name: name,
    description: description,
    createdAt: createdAt,
  );
}