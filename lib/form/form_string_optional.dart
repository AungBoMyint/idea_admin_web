import 'package:formz/formz.dart';

class FormStringOptional extends FormzInput<String, String> {
  const FormStringOptional.pure() : super.pure('');
  const FormStringOptional.dirty({required String value}) : super.dirty(value);

  @override
  String? validator(String value) {
    return null;
  }
}
