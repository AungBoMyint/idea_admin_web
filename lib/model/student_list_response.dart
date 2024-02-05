import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/discount.dart';
import 'package:mmlearning_admin/model/student.dart';

import 'category.dart';
import 'response_error.dart';

part 'student_list_response.freezed.dart';
part 'student_list_response.g.dart';

@freezed
class StudentListResponse with _$StudentListResponse {
  @JsonSerializable(explicitToJson: true)
  factory StudentListResponse({
    int? count,
    String? next,
    List<Student>? results,
    ResponseError? error,
  }) = _StudentListResponse;
  factory StudentListResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentListResponseFromJson(json);
}
