import 'package:formz/formz.dart';

enum VideoError { empty, tooShort }

class FormVideo extends FormzInput<Map<String, dynamic>, VideoError> {
  const FormVideo.pure() : super.pure(const {});
  const FormVideo.dirty({required Map<String, dynamic> value})
      : super.dirty(value);

  @override
  VideoError? validator(Map<String, dynamic> value) {
    if (value.isEmpty) {
      return VideoError.empty;
    } else {
      return null;
    }
  }
}
