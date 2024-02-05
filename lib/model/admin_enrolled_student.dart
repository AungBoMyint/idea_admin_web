import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/student.dart';

part 'admin_enrolled_student.g.dart';
part 'admin_enrolled_student.freezed.dart';

@freezed
class AdminEnrolledStudent with _$AdminEnrolledStudent {
  @JsonSerializable(explicitToJson: true)
  factory AdminEnrolledStudent({
    required Student student,
    required Course course,
    @JsonKey(name: 'subscribed_count') required int subscribedCount,
    required bool subscribed,
    @JsonKey(name: 'expiration_date') required String expirationDate,
  }) = _AdminEnrolledStudent;
  factory AdminEnrolledStudent.fromJson(Map<String, dynamic> json) =>
      _$AdminEnrolledStudentFromJson(json);
}
