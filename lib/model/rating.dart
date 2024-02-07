import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/course.dart';

import 'student.dart';

part 'rating.freezed.dart';
part 'rating.g.dart';

@freezed
class Rating with _$Rating {
  @JsonSerializable(explicitToJson: true)
  factory Rating({
    required int id,
    required double rating,
    dynamic course,
    dynamic student,
  }) = _Rating;
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
