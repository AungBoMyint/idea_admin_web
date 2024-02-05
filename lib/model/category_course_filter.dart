import 'course_filter.dart';

class CategoryCourseFilter extends CourseFilter {
  final int categoryID;
  CategoryCourseFilter({required this.categoryID})
      : super(categoryId: categoryID, featured: null);
}
