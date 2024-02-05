import 'package:freezed_annotation/freezed_annotation.dart';

part 'slider_blog.freezed.dart';
part 'slider_blog.g.dart';

@freezed
class SliderBlog with _$SliderBlog {
  factory SliderBlog({
    required int id,
    required String body,
    required String image,
  }) = _SliderBlog;

  factory SliderBlog.fromJson(Map<String, dynamic> json) =>
      _$SliderBlogFromJson(json);
}
