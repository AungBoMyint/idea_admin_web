import 'package:formz/formz.dart';

enum PasswordError { empty, tooShort }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');
  const Password.dirty({required String value}) : super.dirty(value);
  @override
  PasswordError? validator(String value) {
    if (value.isEmpty) {
      return PasswordError.empty;
    } else if (value.length < 3) {
      return PasswordError.tooShort;
    } else {
      return null;
    }
  }
}
