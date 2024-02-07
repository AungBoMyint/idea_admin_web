import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/rating.dart';
import 'package:mmlearning_admin/model/response_error.dart';

part 'rating_list_response.freezed.dart';
part 'rating_list_response.g.dart';

@freezed
class RatingListResponse with _$RatingListResponse {
  @JsonSerializable(explicitToJson: true)
  factory RatingListResponse({
    String? next,
    List<Rating>? results,
    int? count,
    ResponseError? error,
  }) = _ResponseListResponse;
  factory RatingListResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingListResponseFromJson(json);
}
