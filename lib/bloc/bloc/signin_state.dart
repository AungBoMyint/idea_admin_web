part of 'signin_bloc.dart';

class SigninState extends Equatable {
  final FormzSubmissionStatus status;
  final UserName userName;
  final Password password;
  final bool isValid;
  final bool isSecure;
  const SigninState({
    this.status = FormzSubmissionStatus.initial,
    this.userName = const UserName.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isSecure = true,
  });

  @override
  List<Object?> get props => [status, userName, password, isValid, isSecure];

  SigninState copyWith({
    FormzSubmissionStatus? status,
    UserName? userName,
    Password? password,
    bool? isValid,
    bool? isSecure,
  }) {
    return SigninState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      isSecure: isSecure ?? this.isSecure,
    );
  }
}
