import 'package:formz/formz.dart';

enum DoubleError { lessThanOne }

class FormDoubleRequired extends FormzInput<double, DoubleError> {
  const FormDoubleRequired.pure() : super.pure(0);
  const FormDoubleRequired.dirty({required double value}) : super.dirty(value);

  @override
  DoubleError? validator(double value) {
    if (value == 1.0) {
      return DoubleError.lessThanOne;
    } else {
      return null;
    }
  }
}
