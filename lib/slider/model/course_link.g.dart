// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CourseLink _$$_CourseLinkFromJson(Map<String, dynamic> json) =>
    _$_CourseLink(
      id: json['id'] as int,
      course: (json['course'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CourseLinkToJson(_$_CourseLink instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course': instance.course?.map((e) => e.toJson()).toList(),
    };
