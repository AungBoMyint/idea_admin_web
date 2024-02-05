import 'package:formz/formz.dart';

enum IdListError { empty, tooShort }

class FormIdList extends FormzInput<List<int>, IdListError> {
  const FormIdList.pure() : super.pure(const []);
  const FormIdList.dirty({required List<int> value}) : super.dirty(value);

  @override
  IdListError? validator(List<int> value) {
    return null;
  }
}
