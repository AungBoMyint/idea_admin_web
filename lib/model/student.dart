import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Student with _$Student {
  @JsonSerializable(explicitToJson: true)
  factory Student({
    required int id,
    String? avatar,
    required String membership,
    @JsonKey(defaultValue: 0) int? points,
    required User user,
    @JsonKey(name: "enrolled_courses", defaultValue: 0)
        required int enrolledCourses,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
