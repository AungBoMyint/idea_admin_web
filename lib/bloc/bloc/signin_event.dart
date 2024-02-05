part of 'signin_bloc.dart';

class SigninEvent {}

class UserNameChangeEvent extends SigninEvent {
  final String value;
  UserNameChangeEvent({required this.value});
}

class PasswordChangeEvent extends SigninEvent {
  final String value;
  PasswordChangeEvent({required this.value});
}

class SubmittedEvent extends SigninEvent {}

class SecurePasswordChange extends SigninEvent {}
