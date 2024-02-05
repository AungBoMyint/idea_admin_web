import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/response_error.dart';
import 'slider.dart';

part 'slider_list_response.freezed.dart';
part 'slider_list_response.g.dart';

@freezed
class SliderListResponse with _$SliderListResponse {
  factory SliderListResponse({
    int? count,
    String? next,
    String? previous,
    List<Slider>? results,
    ResponseError? error,
  }) = _SliderListResponse;
  factory SliderListResponse.fromJson(Map<String, dynamic> json) =>
      _$SliderListResponseFromJson(json);
}
