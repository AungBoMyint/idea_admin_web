import 'package:formz/formz.dart';

enum CourseLinkError { empty, tooShort }

class FormCourseLink extends FormzInput<List<int>, CourseLinkError> {
  const FormCourseLink.pure() : super.pure(const []);
  const FormCourseLink.dirty({required List<int> value}) : super.dirty(value);

  @override
  CourseLinkError? validator(List<int> value) {
    return null;
  }
}
