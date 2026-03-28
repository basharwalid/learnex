// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassDto _$ClassDtoFromJson(Map<String, dynamic> json) => ClassDto(
  id: (json['id'] as num?)?.toInt(),
  courseId: (json['course_id'] as num?)?.toInt(),
  classDate: json['class_date'] == null
      ? null
      : DateTime.parse(json['class_date'] as String),
  classTime: json['class_time'] as String?,
  price: (json['price'] as num?)?.toInt(),
  totalSeats: (json['total_seats'] as num?)?.toInt(),
  availableSeats: (json['available_seats'] as num?)?.toInt(),
  meetingLink: json['meeting_link'] as String?,
  status: json['status'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ClassDtoToJson(ClassDto instance) => <String, dynamic>{
  'id': instance.id,
  'course_id': instance.courseId,
  'class_date': instance.classDate?.toIso8601String(),
  'class_time': instance.classTime,
  'price': instance.price,
  'total_seats': instance.totalSeats,
  'available_seats': instance.availableSeats,
  'meeting_link': instance.meetingLink,
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
};
