import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/student.dart';

part 'enrollment.freezed.dart';
part 'enrollment.g.dart';

@freezed
class Enrollment with _$Enrollment {
  @JsonSerializable(explicitToJson: true)
  factory Enrollment({
    required Student student,
    required Course course,
    @JsonKey(name: "subscribed_count") required int subscribedCount,
    required bool subscribed,
    @JsonKey(name: "expiration_date") required String expirationDate,
  }) = _Enrollment;
  factory Enrollment.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentFromJson(json);
}
