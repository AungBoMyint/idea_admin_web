import 'package:freezed_annotation/freezed_annotation.dart';

import 'student.dart';

part 'enrolled_student.freezed.dart';
part 'enrolled_student.g.dart';

@freezed
class EnrolledStudent with _$EnrolledStudent {
  @JsonSerializable(explicitToJson: true)
  factory EnrolledStudent({
    required Student student,
  }) = _EnrolledStudent;
  factory EnrolledStudent.fromJson(Map<String, dynamic> json) =>
      _$EnrolledStudentFromJson(json);
}
