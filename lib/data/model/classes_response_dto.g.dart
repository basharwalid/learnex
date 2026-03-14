// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassesResponseDto _$ClassesResponseDtoFromJson(Map<String, dynamic> json) =>
    ClassesResponseDto(
      id: (json['id'] as num?)?.toInt(),
      courseId: (json['course_id'] as num?)?.toInt(),
      classDate: json['class_date'] as String?,
      classTime: json['class_time'] as String?,
      price: (json['price'] as num?)?.toInt(),
      totalSeats: (json['total_seats'] as num?)?.toInt(),
      availableSeats: (json['available_seats'] as num?)?.toInt(),
      meetingLink: json['meeting_link'],
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ClassesResponseDtoToJson(ClassesResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'class_date': instance.classDate,
      'class_time': instance.classTime,
      'price': instance.price,
      'total_seats': instance.totalSeats,
      'available_seats': instance.availableSeats,
      'meeting_link': instance.meetingLink,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
