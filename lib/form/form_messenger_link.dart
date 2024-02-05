import 'package:formz/formz.dart';

enum MessengerLinkError { empty, tooShort }

class FormMessengerLink extends FormzInput<String, MessengerLinkError> {
  const FormMessengerLink.pure() : super.pure('');
  const FormMessengerLink.dirty({required String value}) : super.dirty(value);

  @override
  MessengerLinkError? validator(String value) {
    return null;
  }
}
