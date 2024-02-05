import 'package:formz/formz.dart';

enum FacebookError { empty, tooShort }

class FormFacebookLink extends FormzInput<String, FacebookError> {
  const FormFacebookLink.pure() : super.pure('');
  const FormFacebookLink.dirty({required String value}) : super.dirty(value);

  @override
  FacebookError? validator(String value) {
    return null;
  }
}
