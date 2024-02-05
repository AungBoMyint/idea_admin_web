part of 'student_bloc.dart';

class StudentEvent {}

class GetStartStudent extends StudentEvent {}

class GetMoreStudent extends StudentEvent {}

class AddStudent extends StudentEvent {}

class DeleteStudent extends StudentEvent {
  final int id;
  DeleteStudent({required this.id});
}

class ChangeAvatar extends StudentEvent {
  final List<int> value;
  ChangeAvatar({required this.value});
}

class ChangeUserName extends StudentEvent {
  final String value;
  ChangeUserName({required this.value});
}

class ChangeEmail extends StudentEvent {
  final String value;
  ChangeEmail({required this.value});
}

class ChangePassword extends StudentEvent {
  final String value;
  ChangePassword({required this.value});
}

class ChangeFirstName extends StudentEvent {
  final String value;
  ChangeFirstName({required this.value});
}

class ChangeLastName extends StudentEvent {
  final String value;
  ChangeLastName({required this.value});
}
