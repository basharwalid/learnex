// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassesRequest _$ClassesRequestFromJson(Map<String, dynamic> json) =>
    ClassesRequest(
      studentId: (json['student_id'] as num?)?.toInt(),
      classId: (json['class_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClassesRequestToJson(ClassesRequest instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'class_id': instance.classId,
    };
