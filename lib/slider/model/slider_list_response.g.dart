// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SliderListResponse _$$_SliderListResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SliderListResponse(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Slider.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] == null
          ? null
          : ResponseError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SliderListResponseToJson(
        _$_SliderListResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
      'error': instance.error,
    };
