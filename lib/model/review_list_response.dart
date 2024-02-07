import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/response_error.dart';

import 'review.dart';

part 'review_list_response.freezed.dart';
part 'review_list_response.g.dart';

@freezed
class ReviewListResponse with _$ReviewListResponse {
  @JsonSerializable(explicitToJson: true)
  factory ReviewListResponse({
    String? next,
    List<Review>? results,
    int? count,
    ResponseError? error,
  }) = _ResponseListResponse;
  factory ReviewListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewListResponseFromJson(json);
}
