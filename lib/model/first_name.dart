import 'package:formz/formz.dart';

enum FirstNameError { empty }

class FirstName extends FormzInput<String, FirstNameError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty({required String value}) : super.dirty(value);
  @override
  FirstNameError? validator(String value) {
    if (value.isEmpty) {
      return FirstNameError.empty;
    } else {
      return null;
    }
  }
}
