import 'package:formz/formz.dart';

enum StringRequiredError { empty, tooShort }

class FormStringRequired extends FormzInput<String, StringRequiredError> {
  const FormStringRequired.pure() : super.pure('');
  const FormStringRequired.dirty({required String value}) : super.dirty(value);

  @override
  StringRequiredError? validator(String value) {
    if (value.isEmpty) {
      return StringRequiredError.empty;
    } else if (value.length < 2) {
      return StringRequiredError.tooShort;
    } else {
      return null;
    }
  }
}
