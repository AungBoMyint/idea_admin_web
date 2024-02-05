import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_message.freezed.dart';
part 'error_message.g.dart';

@freezed
class ErrorMessage with _$ErrorMessage {
  factory ErrorMessage({
    String? message,
  }) = _ErrorMessage;
  factory ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageFromJson(json);
}
