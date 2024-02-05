import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/course.dart';

import 'student.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  @JsonSerializable(explicitToJson: true)
  factory Review({
    required String review,
    required Student? student,
    Course? course,
    required double rating,
    required DateTime date,
  }) = _Review;
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
