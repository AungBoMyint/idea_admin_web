import 'package:freezed_annotation/freezed_annotation.dart';

import 'review.dart';

part 'review_list_response.freezed.dart';
part 'review_list_response.g.dart';

@freezed
class ReviewListResponse with _$ReviewListResponse {
  @JsonSerializable(explicitToJson: true)
  factory ReviewListResponse({
    String? next,
    required List<Review> results,
  }) = _ResponseListResponse;
  factory ReviewListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewListResponseFromJson(json);
}
