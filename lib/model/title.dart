import 'package:formz/formz.dart';

enum TitleError { empty, tooShort }

class FormTitle extends FormzInput<String, TitleError> {
  const FormTitle.pure() : super.pure('');
  const FormTitle.dirty({required String value}) : super.dirty(value);

  @override
  TitleError? validator(String value) {
    if (value.isEmpty) {
      return TitleError.empty;
    } else if (value.length < 3) {
      return TitleError.tooShort;
    } else {
      return null;
    }
  }
}
