part of 'signup_bloc.dart';

class SignupEvent {}

class UserNameChangeEvent extends SignupEvent {
  final String value;
  UserNameChangeEvent({required this.value});
}

class EmailChangeEvent extends SignupEvent {
  final String value;
  EmailChangeEvent({required this.value});
}

class PasswordChangeEvent extends SignupEvent {
  final String value;
  PasswordChangeEvent({required this.value});
}

class FirstNameChangeEvent extends SignupEvent {
  final String value;
  FirstNameChangeEvent({required this.value});
}

class LastNameChangeEvent extends SignupEvent {
  final String value;
  LastNameChangeEvent({required this.value});
}

class SubmittedEvent extends SignupEvent {}
