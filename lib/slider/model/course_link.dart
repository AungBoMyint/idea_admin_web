import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/course.dart';

part 'course_link.freezed.dart';
part 'course_link.g.dart';

@freezed
class CourseLink with _$CourseLink {
  @JsonSerializable(explicitToJson: true)
  factory CourseLink({
    List<Course>? course,
  }) = _CourseLink;
  factory CourseLink.fromJson(Map<String, dynamic> json) =>
      _$CourseLinkFromJson(json);
}
