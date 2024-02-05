import 'package:formz/formz.dart';

enum UserNameError { empty, tooShort }

class UserName extends FormzInput<String, UserNameError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty({required String value}) : super.dirty(value);

  @override
  UserNameError? validator(String value) {
    if (value.isEmpty) {
      return UserNameError.empty;
    } else if (value.length < 3) {
      return UserNameError.tooShort;
    } else {
      return null;
    }
  }
}
