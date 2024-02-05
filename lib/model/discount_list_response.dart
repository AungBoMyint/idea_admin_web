import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/discount.dart';

import 'category.dart';
import 'response_error.dart';

part 'discount_list_response.freezed.dart';
part 'discount_list_response.g.dart';

@freezed
class DiscountListResponse with _$DiscountListResponse {
  @JsonSerializable(explicitToJson: true)
  factory DiscountListResponse({
    int? count,
    String? next,
    List<Discount>? results,
    ResponseError? error,
  }) = _DiscountListResponse;
  factory DiscountListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscountListResponseFromJson(json);
}
