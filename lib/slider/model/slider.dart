import 'package:freezed_annotation/freezed_annotation.dart';

import 'course_link.dart';
import 'facebook_link.dart';
import 'messenger_link.dart';
import 'slider_blog.dart';
import 'youtube_link.dart';

part 'slider.freezed.dart';
part 'slider.g.dart';

@freezed
class Slider with _$Slider {
  @JsonSerializable(explicitToJson: true)
  factory Slider({
    required int id,
    required String title,
    required String image,
    MessengerLink? messengerlink,
    FacebookLink? facebooklink,
    YoutubeLink? youtube,
    CourseLink? courselink,
    List<SliderBlog>? blogs,
  }) = _Slider;
  factory Slider.fromJson(Map<String, dynamic> json) => _$SliderFromJson(json);
}
