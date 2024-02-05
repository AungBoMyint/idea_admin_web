import 'package:freezed_annotation/freezed_annotation.dart';

part 'ratings_summary.freezed.dart';
part 'ratings_summary.g.dart';

@freezed
class RatingsSummary with _$RatingsSummary {
  factory RatingsSummary({
    @JsonKey(name: "rating_one") required int ratingOne,
    @JsonKey(name: "rating_two") required int ratingTwo,
    @JsonKey(name: "rating_three") required int ratingThree,
    @JsonKey(name: "rating_four") required int ratingFour,
    @JsonKey(name: "rating_five") required int ratingFive,
    @JsonKey(name: "total_ratings") required int totalRatings,
  }) = _RatingsSummary;
  factory RatingsSummary.fromJson(Map<String, dynamic> json) =>
      _$RatingsSummaryFromJson(json);

  factory RatingsSummary.empty() => RatingsSummary(
        ratingOne: 0,
        ratingTwo: 0,
        ratingThree: 0,
        ratingFour: 0,
        ratingFive: 0,
        totalRatings: 1,
      );
}
