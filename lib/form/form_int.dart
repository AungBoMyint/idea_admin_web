import 'package:formz/formz.dart';

enum IntError { empty, tooShort }

class FormInt extends FormzInput<int, IntError> {
  const FormInt.pure() : super.pure(0);
  const FormInt.dirty({required int value}) : super.dirty(value);

  @override
  IntError? validator(int value) {
    return null;
  }
}
