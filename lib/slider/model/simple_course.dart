import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_course.freezed.dart';
part 'simple_course.g.dart';

@freezed
class SimpleCourse with _$SimpleCourse {
  factory SimpleCourse({
    required int id,
    required String title,
    required String image,
  }) = _SimpleCourse;
  factory SimpleCourse.fromJson(Map<String, dynamic> json) =>
      _$SimpleCourseFromJson(json);
}
