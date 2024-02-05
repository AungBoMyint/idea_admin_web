
/* 
part 'course_filter.freezed.dart';
part 'course_filter.g.dart';

@freezed
class CourseFilter with _$CourseFilter {
  factory CourseFilter({
    @JsonKey(name: "category_id") int? categoryId,
    @JsonKey(name: "price__lt") int? priceLowerThan,
    @JsonKey(name: "price__gt") int? priceGreaterThan,
    @JsonKey(name: "enroll_students_gt") int? enrollStudentsGreaterThan,
    @JsonKey(name: "enroll_students_lt") int? enrollStudentsLessThan,
    @JsonKey(name: "ratings_gt") double? ratingsGreaterThan,
    @JsonKey(name: "ratings_lt") double? ratingsLessThan,
    @JsonKey(name: "reviews_gt") int? reviewsGreaterThan,
    @JsonKey(name: "reviews_lt") int? reviewsLessThan,
  }) = _CourseFilter;

  factory CourseFilter.fromJson(Map<String, dynamic> json) =>
      _$CourseFilterFromJson(json);
}
 */
abstract class CourseFilter {
  final int? categoryId;
  final int? priceLowerThan;
  final int? priceGreaterThan;
  final int? enrollStudentsGreaterThan;
  final int? enrollStudentsLessThan;
  final double? ratingsGreaterThan;
  final double? ratingsLessThan;
  final int? reviewsGreaterThan;
  final int? reviewsLessThan;
  final bool? featured;
  final String? search;
  CourseFilter({
    this.categoryId,
    this.enrollStudentsGreaterThan,
    this.enrollStudentsLessThan,
    this.priceGreaterThan,
    this.priceLowerThan,
    this.ratingsGreaterThan,
    this.ratingsLessThan,
    this.reviewsGreaterThan,
    this.reviewsLessThan,
    this.featured = false,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "price__lt": priceLowerThan,
        "price__gt": priceGreaterThan,
        "enroll_students_gt": enrollStudentsGreaterThan,
        "enroll_students_lt": enrollStudentsLessThan,
        "ratings_gt": ratingsGreaterThan,
        "ratings_lt": ratingsLessThan,
        "reviews_gt": reviewsGreaterThan,
        "reviews_lt": reviewsLessThan,
        "featured": featured,
      };
}
