import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog.freezed.dart';
part 'blog.g.dart';

@freezed
class Blog with _$Blog {
  factory Blog({
    String? image,
    required String title,
    required String content,
    required int duration,
  }) = _Blog;
  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);
}
