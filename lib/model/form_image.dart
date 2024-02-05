import 'package:formz/formz.dart';

enum FormImageError { empty, tooShort }

class FormImage extends FormzInput<List<int>, FormImageError> {
  const FormImage.pure() : super.pure(const []);
  const FormImage.dirty({required List<int> value}) : super.dirty(value);

  @override
  FormImageError? validator(List<int> value) {
    if (value.isEmpty) {
      return FormImageError.empty;
    } else {
      return null;
    }
  }
}
