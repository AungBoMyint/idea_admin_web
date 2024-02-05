import 'package:formz/formz.dart';

enum LastNameError { empty }

class LastName extends FormzInput<String, LastNameError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty({required String value}) : super.dirty(value);
  @override
  LastNameError? validator(String value) {
    if (value.isEmpty) {
      return LastNameError.empty;
    } else {
      return null;
    }
  }
}
