import 'package:json_annotation/json_annotation.dart';

part 'classes_request_dto.g.dart';

@JsonSerializable()
class ClassesRequestDto{
  @JsonKey(name: "student_id")
  final int? studentId;
  @JsonKey(name: "class_id")
  final int? classId;

  ClassesRequestDto({this.studentId, this.classId});

  factory ClassesRequestDto.fromJson(Map<String, dynamic> json) {
    return _$ClassesRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClassesRequestDtoToJson(this);
  }
}
