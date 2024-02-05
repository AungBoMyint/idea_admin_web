// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Slider _$$_SliderFromJson(Map<String, dynamic> json) => _$_Slider(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      messengerlink: json['messengerlink'] == null
          ? null
          : MessengerLink.fromJson(
              json['messengerlink'] as Map<String, dynamic>),
      facebooklink: json['facebooklink'] == null
          ? null
          : FacebookLink.fromJson(json['facebooklink'] as Map<String, dynamic>),
      youtube: json['youtube'] == null
          ? null
          : YoutubeLink.fromJson(json['youtube'] as Map<String, dynamic>),
      courselink: json['courselink'] == null
          ? null
          : CourseLink.fromJson(json['courselink'] as Map<String, dynamic>),
      blogs: (json['blogs'] as List<dynamic>?)
          ?.map((e) => SliderBlog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SliderToJson(_$_Slider instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'messengerlink': instance.messengerlink?.toJson(),
      'facebooklink': instance.facebooklink?.toJson(),
      'youtube': instance.youtube?.toJson(),
      'courselink': instance.courselink?.toJson(),
      'blogs': instance.blogs?.map((e) => e.toJson()).toList(),
    };
