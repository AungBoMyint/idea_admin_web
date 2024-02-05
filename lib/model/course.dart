import 'package:freezed_annotation/freezed_annotation.dart';
import 'enrolled_student.dart';
import 'section.dart';
import 'subscription_info.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  @JsonSerializable(explicitToJson: true)
  factory Course({
    required int id,
    required String title,
    required String image,
    String? video,
    String? desc,
    int? price,
    @JsonKey(name: "category_id") int? categoryId,
    bool? featured,
    @JsonKey(name: "total_durations") double? totalDurations,
    @JsonKey(name: "discount_price") double? discountPrice,
    @JsonKey(name: "enroll_students_count") int? enrollStudentsCount,
    @JsonKey(name: "ratings_avg", defaultValue: 0.0) double? averageRatings,
    @JsonKey(name: "reviews_count") int? reviewsCount,
    @JsonKey(name: "is_enrolled") bool? isEnrolled,
    @JsonKey(name: "total_subsections") int? lessons,
    @JsonKey(name: "subscribe_info") SubscriptionInfo? subscriptionInfo,
    double? progress,
    int? videos,
    int? pdfs,
    int? blogs,
    @JsonKey(name: "enroll_students", defaultValue: [])
        List<EnrolledStudent>? enrollStudents,
    List<Section>? sections,
  }) = _Course;
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  factory Course.empty() => Course(
        id: 1,
        title: "",
        image: "",
        desc: "",
        totalDurations: 0,
        price: 0,
        enrollStudentsCount: 0,
        reviewsCount: 0,
        isEnrolled: false,
        progress: 0.0,
        videos: 0,
        pdfs: 0,
        blogs: 0,
        lessons: 0,
        featured: false,
        categoryId: 0,
      );
}
