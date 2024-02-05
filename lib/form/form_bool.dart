import 'package:formz/formz.dart';

enum BoolError { empty, tooShort }

class FormBool extends FormzInput<bool, BoolError> {
  const FormBool.pure() : super.pure(false);
  const FormBool.dirty({required bool value}) : super.dirty(value);

  @override
  BoolError? validator(bool value) {
    return null;
  }
}
