import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';
import 'response_error.dart';

part 'category_list_response.freezed.dart';
part 'category_list_response.g.dart';

@freezed
class CategoryListResponse with _$CategoryListResponse {
  @JsonSerializable(explicitToJson: true)
  factory CategoryListResponse({
    int? count,
    String? next,
    List<Category>? results,
    ResponseError? error,
  }) = _CategoryListResponse;
  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryListResponseFromJson(json);
}
