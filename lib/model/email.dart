import 'package:formz/formz.dart';

enum EmailError { invalid, emtpy }

class Email extends FormzInput<String, EmailError> {
  const Email.pure() : super.pure('');
  const Email.dirty({required String value}) : super.dirty(value);
  @override
  EmailError? validator(value) {
    if (value.isEmpty) {
      return EmailError.emtpy;
    } else if (!isEmailValid(value)) {
      return EmailError.invalid;
    } else {
      return null;
    }
  }
}

bool isEmailValid(String email) {
  // Regular expression pattern for basic email validation
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  return emailRegex.hasMatch(email);
}
