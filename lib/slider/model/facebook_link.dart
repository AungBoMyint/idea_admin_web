import 'package:freezed_annotation/freezed_annotation.dart';

part 'facebook_link.freezed.dart';
part 'facebook_link.g.dart';

@freezed
class FacebookLink with _$FacebookLink {
  factory FacebookLink({
    required String link,
  }) = _FacebookLink;
  factory FacebookLink.fromJson(Map<String, dynamic> json) =>
      _$FacebookLinkFromJson(json);
}
