import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_message.dart';

part 'response_error.freezed.dart';
part 'response_error.g.dart';

@freezed
class ResponseError with _$ResponseError {
  factory ResponseError({
    String? detail,
    String? code,
    List<ErrorMessage>? messages,
  }) = _ResponseError;
  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);
}
