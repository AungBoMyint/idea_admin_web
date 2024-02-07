import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_link.freezed.dart';
part 'youtube_link.g.dart';

@freezed
class YoutubeLink with _$YoutubeLink {
  factory YoutubeLink({
    required int id,
    required String link,
  }) = _YoutubeLink;
  factory YoutubeLink.fromJson(Map<String, dynamic> json) =>
      _$YoutubeLinkFromJson(json);
}
