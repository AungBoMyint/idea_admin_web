import 'package:freezed_annotation/freezed_annotation.dart';

import 'blog.dart';
import 'pdf.dart';
import 'video.dart';

part 'subsection.freezed.dart';
part 'subsection.g.dart';

@freezed
class SubSection with _$SubSection {
  @JsonSerializable(explicitToJson: true)
  factory SubSection({
    required int id,
    required String title,
    bool? completed,
    Video? video,
    Blog? blog,
    Pdf? pdf,
  }) = _SubSection;
  factory SubSection.fromJson(Map<String, dynamic> json) =>
      _$SubSectionFromJson(json);
}
