part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final Student? student;
  const AuthState({required this.authStatus, required this.student});

  @override
  List<Object?> get props => [authStatus, student];

  AuthState copyWith({
    AuthStatus? authStatus,
    Student? student,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      student: student ?? this.student,
    );
  }
}
