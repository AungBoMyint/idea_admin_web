import 'package:freezed_annotation/freezed_annotation.dart';

import 'course.dart';
import 'response_error.dart';

part 'course_list_response.freezed.dart';
part 'course_list_response.g.dart';

@freezed
class CourseListResponse with _$CourseListResponse {
  @JsonSerializable(explicitToJson: true)
  factory CourseListResponse({
    String? next,
    int? count,
    List<Course>? results,
    ResponseError? error,
  }) = _CourseListResponse;
  factory CourseListResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseListResponseFromJson(json);
}
