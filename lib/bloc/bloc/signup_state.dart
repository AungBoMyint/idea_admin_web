part of 'signup_bloc.dart';

enum SignupFailType { empty, userNameExist }

class SignupState extends Equatable {
  final UserName userName;
  final Email email;
  final FirstName firstName;
  final LastName lastName;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final SignupFailType failType;
  const SignupState({
    this.userName = const UserName.dirty(value: "default-user-name"),
    this.email = const Email.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.failType = SignupFailType.empty,
  });

  @override
  List<Object?> get props => [
        userName,
        email,
        firstName,
        lastName,
        password,
        isValid,
        status,
        failType,
      ];

  SignupState copyWith({
    UserName? userName,
    Email? email,
    FirstName? firstName,
    LastName? lastName,
    Password? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    SignupFailType? failType,
  }) {
    return SignupState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      failType: failType ?? this.failType,
    );
  }
}
