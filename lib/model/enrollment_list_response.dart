import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/enrollment.dart';

import 'response_error.dart';

part 'enrollment_list_response.freezed.dart';
part 'enrollment_list_response.g.dart';

@freezed
class EnrollmentListResponse with _$EnrollmentListResponse {
  @JsonSerializable(explicitToJson: true)
  factory EnrollmentListResponse({
    int? count,
    String? next,
    List<Enrollment>? results,
    ResponseError? error,
  }) = _EnrollmentListResponse;
  factory EnrollmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentListResponseFromJson(json);
}
