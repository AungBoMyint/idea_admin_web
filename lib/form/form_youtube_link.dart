import 'package:formz/formz.dart';

enum YoutubeError { empty, tooShort }

class FormYoutubeLink extends FormzInput<String, YoutubeError> {
  const FormYoutubeLink.pure() : super.pure('');
  const FormYoutubeLink.dirty({required String value}) : super.dirty(value);

  @override
  YoutubeError? validator(String value) {
    return null;
  }
}
