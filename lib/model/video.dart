import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  factory Video({
    required int id,
    Map<String, dynamic>? data,
    @JsonKey(name: "video_url") required String videoUrl,
    required String duration,
  }) = _Video;
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  factory Video.empty() => Video(id: 0, videoUrl: "", duration: "");
}
