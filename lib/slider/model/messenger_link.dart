import 'package:freezed_annotation/freezed_annotation.dart';

part 'messenger_link.freezed.dart';
part 'messenger_link.g.dart';

@freezed
class MessengerLink with _$MessengerLink {
  factory MessengerLink({
    required int id,
    required String link,
  }) = _MessengerLink;
  factory MessengerLink.fromJson(Map<String, dynamic> json) =>
      _$MessengerLinkFromJson(json);
}
