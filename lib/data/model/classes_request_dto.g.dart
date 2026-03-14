// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassesRequestDto _$ClassesRequestDtoFromJson(Map<String, dynamic> json) =>
    ClassesRequestDto(
      studentId: (json['student_id'] as num?)?.toInt(),
      classId: (json['class_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClassesRequestDtoToJson(ClassesRequestDto instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'class_id': instance.classId,
    };
