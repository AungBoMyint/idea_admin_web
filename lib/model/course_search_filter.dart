import 'course_filter.dart';

class CourseSearchFilter {
  final String search;
  CourseSearchFilter({
    required this.search,
  });

  Map<String, dynamic> toJson() => {
        "search": search,
      };
}

class Filter extends CourseFilter {
  Filter({
    super.enrollStudentsGreaterThan,
    super.enrollStudentsLessThan,
    super.priceGreaterThan,
    super.priceLowerThan,
    super.reviewsGreaterThan,
    super.ratingsGreaterThan,
    super.ratingsLessThan,
    super.reviewsLessThan,
  });
}
