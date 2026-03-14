import 'package:json_annotation/json_annotation.dart';
import 'package:learnex/data/model/classes_request_dto.dart';

part 'classes_request.g.dart';

@JsonSerializable()
class ClassesRequest {
  @JsonKey(name: "student_id")
  final int? studentId;
  @JsonKey(name: "class_id")
  final int? classId;

  ClassesRequest({this.studentId, this.classId});

  factory ClassesRequest.fromJson(Map<String, dynamic> json) {
    return _$ClassesRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClassesRequestToJson(this);
  }

  ClassesRequestDto toData() {
    return ClassesRequestDto(studentId: studentId, classId: classId);
  }
}
