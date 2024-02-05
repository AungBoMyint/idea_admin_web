import 'package:freezed_annotation/freezed_annotation.dart';

import 'subsection.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@freezed
class Section with _$Section {
  @JsonSerializable(explicitToJson: true)
  factory Section({
    required int id,
    required String title,
    List<SubSection>? subsections,
  }) = _Section;
  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}
